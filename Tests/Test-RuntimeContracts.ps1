param(
 [string]$GameRoot='C:/Program Files (x86)/Steam/steamapps/common/RimWorld',
 [string]$Workshop='C:/Program Files (x86)/Steam/steamapps/workshop/content/294100'
)
$ErrorActionPreference='Stop'
$root=Split-Path $PSScriptRoot
$managed=Join-Path $GameRoot 'RimWorldWin64_Data/Managed'
Get-ChildItem $managed -Filter *.dll | ForEach-Object {try{$null=[Reflection.Assembly]::LoadFrom($_.FullName)}catch{}}
$game=[Reflection.Assembly]::LoadFrom((Join-Path $managed 'Assembly-CSharp.dll'))
$null=[Reflection.Assembly]::LoadFrom("$Workshop/836308268/1.6/Assemblies/BadHygiene.dll")
$mod=[Reflection.Assembly]::LoadFrom("$root/Mod/Assemblies/ManureComposting.dll")
# Disable profiling only: no player Prefs exist in this headless process.
[Verse.DeepProfiler]::enabled=$false
$script:checks=0
function Assert($condition,[string]$message){if(!$condition){throw $message};$script:checks++;Write-Output "PASS $message"}
function Set-Field($obj,$name,$value){
 $type=$obj.GetType();$field=$null
 while($type -and !$field){$field=$type.GetField($name,[Reflection.BindingFlags]'Instance,Public,NonPublic,DeclaredOnly');$type=$type.BaseType}
 if(!$field){throw "Missing runtime field $name"};$field.SetValue($obj,$value)
}
function Read-Operation($node){
 $type=$game.GetType("Verse.$($node.Class)",$true)
 $op=[Activator]::CreateInstance($type)
 Set-Field $op xpath ([string]$node.xpath)
 if($node.match){Set-Field $op match (Read-Operation $node.match)}
 if($node.value){
  $container=[Activator]::CreateInstance($game.GetType('Verse.XmlContainer',$true))
  Set-Field $container node $node.value
  Set-Field $op value $container
 }
 return $op
}
function Apply-Patches([xml]$doc){
 foreach($f in Get-ChildItem "$root/Mod/Patches" -Filter *.xml){
  [xml]$patch=Get-Content $f.FullName -Raw
  foreach($node in $patch.Patch.Operation){$op=Read-Operation $node;Assert ($op.Apply($doc)) "Real patch engine: $($f.Name) $($node.xpath)"}
 }
}
[xml]$absent='<Defs/>'
Apply-Patches $absent
Assert ($absent.DocumentElement.ChildNodes.Count -eq 0) 'Absent optional targets stay absent'
[xml]$present='<Defs/>'
foreach($dir in @("$Workshop/836308268/1.6/Defs","$Workshop/3225843229/Defs","$Workshop/3225843229/1.6/Defs")){
 foreach($f in Get-ChildItem $dir -Filter *.xml -Recurse){
  [xml]$doc=Get-Content $f.FullName -Raw
  foreach($node in $doc.Defs.ChildNodes){if($node.NodeType -eq 'Element'){$null=$present.DocumentElement.AppendChild($present.ImportNode($node,$true))}}
 }
}
Apply-Patches $present
Assert ($present.SelectNodes('Defs/ThingDef[defName="BiosolidsComposter"]/designatorDropdown[text()="Nelim_Composters"]').Count -eq 1) 'DBH composter joins dropdown once'
foreach($recipe in 'MakeCompost','MakeCompost5'){
 foreach($filter in 'ingredients/li/filter','fixedIngredientFilter'){
  foreach($ingredient in 'Manure','DryManure'){
   Assert ($present.SelectNodes("Defs/RecipeDef[defName='$recipe']/$filter/thingDefs/li[text()='$ingredient']").Count -ge 1) "$recipe accepts $ingredient in $filter"
  }
 }
 Assert ($present.SelectNodes("Defs/RecipeDef[defName='$recipe']/defaultIngredientFilter/thingDefs/li[text()='DryManure']").Count -eq 1) "$recipe defaults to dried manure"
 Assert ($present.SelectNodes("Defs/RecipeDef[defName='$recipe']/defaultIngredientFilter/thingDefs/li[text()='Manure']").Count -eq 0) "$recipe does not default to fresh manure"
}
[xml]$partial='<Defs><ThingDef><defName>BurnItForFuel</defName><building><fixedStorageSettings><filter/></fixedStorageSettings></building></ThingDef></Defs>'
Apply-Patches $partial
Assert ($partial.SelectNodes('//thingDefs').Count -eq 0) 'Incomplete optional filter is safely skipped'
[xml]$burn='<Defs><ThingDef><defName>BurnItForFuel</defName><building><fixedStorageSettings><filter><thingDefs><li>WoodLog</li></thingDefs></filter></fixedStorageSettings></building></ThingDef></Defs>'
Apply-Patches $burn
Assert ($burn.SelectNodes('//thingDefs/li[text()="DryManure"]').Count -eq 1) 'Compatible optional burner receives dried manure'
# Exercise the shipped WorkGivers against the actual game DefDatabase, outside a running map.
$thingType=$game.GetType('Verse.ThingDef',$true)
# A metadata-only Def avoids Unity texture creation; its name is the only field used here.
$def=[Runtime.Serialization.FormatterServices]::GetUninitializedObject($thingType);$thingType.GetField('defName').SetValue($def,'Nelim_ManureComposter')
$db=$game.GetType('Verse.DefDatabase' + [char]96 + '1').MakeGenericType($thingType)
$db.GetMethod('Add',[type[]]@($thingType)).Invoke($null,@($def))
foreach($name in 'WorkGiver_FillManureComposter','WorkGiver_UnloadManureComposter'){
 $giver=[Activator]::CreateInstance($mod.GetType("ManureComposting.$name",$true))
 Assert ([object]::ReferenceEquals($giver.PotentialWorkThingRequest.SingleDef,$def)) "$name scans the registered manure composter"
 Assert ([object]::ReferenceEquals($giver.PotentialWorkThingRequest.SingleDef,$def)) "$name cached lookup remains stable"
}
Write-Output "$script:checks checks passed. No map, UI, pawn job execution or persistence test is claimed."






