param([string]$Workshop='C:/Program Files (x86)/Steam/steamapps/workshop/content/294100')
$ErrorActionPreference='Stop'
$root=Split-Path $PSScriptRoot
Add-Type -Path "$PSScriptRoot/TextAdapterTests.cs","$root/Source/Building_ManureComposter.cs"
[TextAdapterTests]::Run($root,$Workshop)
