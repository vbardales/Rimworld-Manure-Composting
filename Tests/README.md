# Tests

The plan, the passes, the conditions to reach `tested` and the evidence policy are in [../TESTING.md](../TESTING.md). This file says how to run
the offline part. Run each script in a fresh process (they load different test assemblies):

- `pwsh -NoProfile -File Tests/Test-RuntimeContracts.ps1`: actual RimWorld patch operations against installed DBH/Fertile Fields Defs, absent and
  incomplete optional targets, a synthetic compatible burner, and shipped WorkGiver scan/caching behavior. No pawn/map simulation. Game profiler is
  disabled because a headless process has no Prefs; the test Def is metadata-only to avoid Unity texture initialization.
- `pwsh -NoProfile -File Tests/Test-TextAdapter.ps1`: compiles the real building text adapter against a minimal DBH/Verse test double, using installed
  EN/FR strings. Checks quantities, preservation of unrelated text, completed/minified states, gizmo identity/order and action preservation. This is a
  unit test, not a substitute for the live DBH/UI.
- `python Tests/test_resources.py`: XML syntax, owned and reused translation coverage, placeholders/targets, metadata, images, licence/attribution
  copies, and the absence of a settings page, a `MainButtonDef` and a declared incompatibility. Standard library only.

The runtime scripts accept `-Workshop`; the first also accepts `-GameRoot`. The resource script's default paths are declared at the top. Dependency
resources remain local and are not redistributed with the tests.

The shared parent tools `scripts/Check-XmlFields.ps1`, `Check-XmlClasses.ps1`, `Check-DefRefs.ps1` and `Check-DefInjected.ps1` are run against the
installed game and dependencies and are not vendored here; their parameters are in [../docs/runs/2026-09-28.md](../docs/runs/2026-09-28.md).

`Tests/Pickle/` is the in-game suite, run only through the shared queue (see `Tests/Pickle/README.md`). `Tests/Results/` holds the latest output of
each offline test, on disk and ignored by git.
