# Validation results — 2026-09-13

Base Git revision: 621eb1f403c89f6ebc1cd682873148df1befcea8, with the working-tree fixes
listed in CHANGELOG 1.0.1. artifact-hashes.csv identifies every Source/ and Mod/ file
in the validated deliverable (not just the base commit).

- Build: dotnet build Source/ManureComposting.csproj; zero warnings/errors.
  Final output is Mod/Assemblies/ManureComposting.dll, SHA256
  FAA8958242B5F88768A2024A45E8796F72B18602B4675A9F8E2EB320CC079C62.
- Test-RuntimeContracts.ps1: 40 checks passed using actual installed RimWorld
  PatchOperation classes, DBH/Fertile Fields Defs and the shipped WorkGivers.
  Both root and 1.6 Fertile Fields Def directories are included.
  Optional burner coverage uses a synthetic compatible target, not a live continuation.
- Test-TextAdapter.ps1: 20 unit checks passed using the actual adapter source and EN/FR
  dependency strings with a DBH/Verse base test double. No actual map/UI simulation.
- test_resources.py: 88 checks passed. Eleven French DefInjected entries (nine owned
  fields plus two DBH job reports), two owned Keyed entries per language, inherited DBH
  key parameter parity and vanilla temperature/failure/ruin keys checked.
- ../scripts/Check-XmlFields.ps1: six definition/metadata/patch files, no unknown fields.
- ../scripts/Check-XmlClasses.ps1: nine referenced types resolved.
- ../scripts/Check-DefRefs.ps1: four owned Defs, no unresolved/wrong-type references or parents.
- ../scripts/Check-DefInjected.ps1: eleven entries, zero errors. The MayRequire advisory
  concerns missing hard dependencies; both are mandatory in About.xml, so there is no
  supported configuration that loads this translation without those Defs.
  The shared checker does not implement DBH's unrelated PatchOperationAddDesignator;
  none of these eleven translation targets is created by that operation.
- Visual QA: Preview 896x504, 561109 bytes; ModIcon 128x128, 22204 bytes.
  Inspected original/final Preview and 268px version, and icon at 32px.
  Segoe UI regular/semibold font files exist and browser font readiness passed.
  Rendered-background minimum contrast: title 6.73:1, summary 7.08:1, badge 8.70:1.
  See art-qa.json.

## Shared XML command parameters

ModPath/TransMod: this repository's Mod directory.
ExtraAssemblies: Workshop/836308268/1.6/Assemblies/BadHygiene.dll and
Mod/Assemblies/ManureComposting.dll.
TypeLists: ../rw16_types.txt plus a reflected DBH type list in .build/audit/dbh-types.txt;
SourceDirs: Source/.
DefRefs AlsoScan: Workshop/836308268/1.6, Workshop/3784198780,
Workshop/3225843229/Defs and Workshop/3225843229/1.6.
DefInjected Targets: Mod/ and Workshop/836308268/1.6.
Workshop is C:/Program Files (x86)/Steam/steamapps/workshop/content/294100.
DBH reports version 3.1.2800; dependencies and game declare/support RimWorld 1.6.

## Limits

No in-game scenario, Player.log review, save round-trip, UI layout or RIMMSQOL integration
was executed. TEST_SCENARIOS.md lists the final checks. State is done (ready for final
in-game validation), not tested. The Windows game cannot be driven through the native
computer UI tools available to this task, so runtime results are not fabricated.
Initial headless harness failures (profiler Prefs, Unity constructor, PowerShell reflection
binding) were corrected in the test setup; these were not failures observed in the mod.
