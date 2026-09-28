<#
.SYNOPSIS
  Offline check of this suite before any ticket is filed: no game, a few seconds.

.DESCRIPTION
  A step that Pickle cannot match costs a whole run, and one it matches twice fails a healthy scenario as
  "Ambiguous step". So, with the expression engine the game uses:

    1. Every pattern declared under Source\ compiles, and none is declared twice.
    2. Every step line of every feature matches exactly ONE expression, among this suite's patterns and
       Pickle's own vocabulary (read from the attributes of the installed Pickle assemblies).
    3. Every pass map exists, ends with a newline (the staging silently drops an unterminated last line),
       and names a packageId with a numeric Workshop id or a path: line.
    4. The test companion's packageId is the one the maps and the About agree on, and the built step
       assembly under Mod\Pickle\Assemblies is newer than every source file.

  It does not run a scenario. A green here says the vocabulary is well formed, nothing about the game.

.EXAMPLE
  powershell.exe -ExecutionPolicy Bypass -File Tests/Pickle/Check-Steps.ps1
#>
param(
    [string]$PickleAssemblies = $(if (Test-Path 'C:\Program Files (x86)\Steam\steamapps\workshop\content\294100\3791648678\1.6\Assemblies') { 'C:\Program Files (x86)\Steam\steamapps\workshop\content\294100\3791648678\1.6\Assemblies' } else { 'C:\Program Files (x86)\Steam\steamapps\workshop\content\294100\3791648678\Assemblies' }),
    [string]$Cecil = "$env:USERPROFILE\.nuget\packages\mono.cecil\0.11.5\lib\net40\Mono.Cecil.dll"
)
$ErrorActionPreference = 'Stop'
$here = $PSScriptRoot
$bad = 0

foreach ($dll in 'CucumberExpressions.dll', 'RimWorks.Pickle.Core.dll') {
    $path = Join-Path $PickleAssemblies $dll
    if (-not (Test-Path $path)) { throw "$dll not found under $PickleAssemblies" }
    [Reflection.Assembly]::LoadFrom($path) | Out-Null
}
Add-Type -Path $Cecil
$core = [AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GetName().Name -eq 'RimWorks.Pickle.Core' }
$registryType = $core.GetType('RimWorks.Pickle.Core.Steps.PickleParameterTypeRegistry')
if (-not $registryType) { throw 'PickleParameterTypeRegistry no longer exists: Pickle renamed it, update this script.' }
$registry = [Activator]::CreateInstance($registryType)
function New-Expr($pattern) { New-Object CucumberExpressions.CucumberExpression($pattern, $registry) }

# --- 1. this suite's patterns ---------------------------------------------------------------------
$attr = '\[(?:Given|When|Then)\("((?:[^"\\]|\\.)*)"'
$mine = @()
foreach ($f in Get-ChildItem -LiteralPath (Join-Path $here 'Source') -Filter *.cs) {
    foreach ($m in [regex]::Matches([IO.File]::ReadAllText($f.FullName), $attr)) {
        $mine += [pscustomobject]@{ File = $f.Name; Pattern = ($m.Groups[1].Value -replace '\\\\', '\' -replace '\\"', '"') }
    }
}
if ($mine.Count -eq 0) { throw 'no step pattern found under Source: the attribute shape this script looks for has changed' }
foreach ($g in ($mine | Group-Object Pattern | Where-Object { $_.Count -gt 1 })) {
    Write-Host "DUPLICATE  $($g.Name)" -ForegroundColor Red; $bad++
}
$exprs = @()
foreach ($d in $mine) {
    try { $exprs += [pscustomobject]@{ Source = 'suite'; Pattern = $d.Pattern; Regex = (New-Expr $d.Pattern).Regex } }
    catch {
        $e = $_.Exception; while ($e.InnerException) { $e = $e.InnerException }
        Write-Host "INVALID  $($d.File): $($d.Pattern)`n         $($e.Message.Split("`n")[0])" -ForegroundColor Red; $bad++
    }
}

# --- Pickle's own vocabulary ------------------------------------------------------------------------
$pickleCount = 0
foreach ($name in 'RimWorks.Pickle.Vanilla.dll', 'RimWorks.Pickle.dll') {
    $asm = [Mono.Cecil.AssemblyDefinition]::ReadAssembly((Join-Path $PickleAssemblies $name))
    foreach ($t in $asm.MainModule.GetTypes()) {
        foreach ($m in $t.Methods) {
            foreach ($a in $m.CustomAttributes | Where-Object { $_.AttributeType.Name -in 'GivenAttribute', 'WhenAttribute', 'ThenAttribute' }) {
                try { $exprs += [pscustomobject]@{ Source = 'pickle'; Pattern = [string]$a.ConstructorArguments[0].Value; Regex = (New-Expr ([string]$a.ConstructorArguments[0].Value)).Regex }; $pickleCount++ } catch { }
            }
        }
    }
}
# Handled by the runner without an attribute this extraction sees; Pickle's own features use them verbatim
# (Pickle/Features/save-reload.feature and the fixtures section of its step catalogue).
foreach ($p in 'the save {string} is loaded', 'I save and reload', 'I save and reload as {string}', 'the save round trips') { $exprs += [pscustomobject]@{ Source = 'pickle-engine'; Pattern = $p; Regex = (New-Expr $p).Regex } }

# --- 2. every step line of every feature -----------------------------------------------------------
$featureDir = Join-Path $here 'Mod\Pickle\Features'
$lines = 0
foreach ($file in Get-ChildItem -LiteralPath $featureDir -Filter *.feature) {
    foreach ($raw in [IO.File]::ReadAllLines($file.FullName)) {
        if ($raw.Trim() -notmatch '^(Given|When|Then|And|But)\s+(.+)$') { continue }
        $step = $Matches[2].Trim(); $lines++
        $hits = @($exprs | Where-Object { $_.Regex.IsMatch($step) })
        if ($hits.Count -eq 0) { Write-Host "UNDEFINED  $($file.Name): $step" -ForegroundColor Red; $bad++ }
        elseif ($hits.Count -gt 1) {
            Write-Host "AMBIGUOUS  $($file.Name): $step" -ForegroundColor Red
            foreach ($h in $hits) { Write-Host "             $($h.Source): $($h.Pattern)" }
            $bad++
        }
    }
}

# --- 3. pass maps -----------------------------------------------------------------------------------
$maps = Get-ChildItem -LiteralPath $here -Filter 'wsl-*.map'
foreach ($map in $maps) {
    $bytes = [IO.File]::ReadAllBytes($map.FullName)
    if ($bytes.Length -eq 0 -or $bytes[$bytes.Length - 1] -ne 10) { Write-Host "NO TRAILING NEWLINE  $($map.Name)" -ForegroundColor Red; $bad++ }
    foreach ($l in [IO.File]::ReadAllLines($map.FullName)) {
        $t = $l.Trim()
        if ($t -eq '' -or $t.StartsWith('#')) { continue }
        if ($t -notmatch '^(first:)?(!?[A-Za-z0-9_.]+)\s+(\d+|path:\S+)?$' -and $t -notmatch '^!ludeon\.rimworld\.\w+$') {
            Write-Host "MALFORMED LINE  $($map.Name): $t" -ForegroundColor Red; $bad++
        }
    }
}

# --- 4. companion identity and build freshness ------------------------------------------------------
$about = [xml](Get-Content -LiteralPath (Join-Path $here 'Mod\About\About.xml') -Raw)
if ($about.ModMetaData.packageId -ne 'nelim.manurecomposting.pickletests') { Write-Host "COMPANION packageId is $($about.ModMetaData.packageId)" -ForegroundColor Red; $bad++ }
$dll = Join-Path $here 'Mod\Pickle\Assemblies\ManureComposting.PickleSteps.dll'
if (-not (Test-Path $dll)) { Write-Host "NOT BUILT  $dll" -ForegroundColor Red; $bad++ }
else {
    $newest = Get-ChildItem -LiteralPath (Join-Path $here 'Source') -Filter *.cs | Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if ((Get-Item $dll).LastWriteTime -lt $newest.LastWriteTime) { Write-Host "STALE  the step assembly is older than $($newest.Name): rebuild it" -ForegroundColor Red; $bad++ }
}

"{0} step patterns, {1} Pickle patterns, {2} feature step lines, {3} pass maps checked." -f $mine.Count, $pickleCount, $lines, $maps.Count
if ($bad -gt 0) { Write-Host "$bad problem(s)." -ForegroundColor Red; exit 1 }
Write-Host 'Every step line matches exactly one expression; maps and companion are well formed.' -ForegroundColor Green
