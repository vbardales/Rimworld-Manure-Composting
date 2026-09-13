# Tests

Run each PowerShell script in a fresh process (they load different test assemblies):

- pwsh -NoProfile -File Tests/Test-RuntimeContracts.ps1: actual RimWorld patch operations against installed DBH/Fertile Fields Defs, absent and incomplete optional targets, a synthetic compatible burner, and shipped WorkGiver scan/caching behavior. No pawn/map simulation. Game profiler is disabled because a headless process has no Prefs; the test Def is metadata-only to avoid Unity texture initialization.
- pwsh -NoProfile -File Tests/Test-TextAdapter.ps1: compiles the real building text adapter against a minimal DBH/Verse test double, using installed EN/FR strings. Checks quantities, preservation of unrelated text, completed/minified states, gizmo identity/order and action preservation. This is a unit test, not a substitute for the live DBH/UI.
- python Tests/test_resources.py: XML syntax, owned and reused translation coverage, placeholders/targets, metadata, images and licence/attribution copies. Standard library only.

The runtime scripts accept -Workshop; the first also accepts -GameRoot. The resource
script's default paths are declared at the top. Dependency resources remain local and are
not redistributed with the tests.

The shared parent tools Check-XmlFields.ps1, Check-XmlClasses.ps1, Check-DefRefs.ps1 and
Check-DefInjected.ps1 were also run; commands/results are recorded in Results/README.md.
They need the installed game/dependencies and are not vendored here.
See ../TEST_SCENARIOS.md for final functional validation. No in-game test has been claimed.
