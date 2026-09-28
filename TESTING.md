# Manure Composting - testing

Two levels. Everything that can be proven outside the game is proven outside the game, in seconds. What only a
running game can show is played by Pickle, in the headless WSL install, through the shared queue. `done` means the
offline tests are green and the Pickle suite is written and justified. `tested` means the passes below have run,
their reports were read and their `@review` captures were opened.

## What each level covers

| Level | Where | Covers |
| --- | --- | --- |
| Patch and WorkGiver contracts | `Tests/Test-RuntimeContracts.ps1` | The real patch operations of the game applied to the installed DBH, Burok and Fertile Fields defs (with and without the optional targets, and against incomplete ones); the two WorkGivers scanning and caching the registered def. No pawn, no map. |
| Text adapter | `Tests/Test-TextAdapter.ps1`, `Tests/TextAdapterTests.cs` | The building subclass against a minimal DBH/Verse test double: quantities, untouched lines, finished and minified states, gizmo identity, order and action. |
| Packaging and localization | `Tests/test_resources.py` | XML syntax; every owned and reused translation key in English and French; placeholders and DefInjected targets; metadata; images; licence copies; **no settings class, no `MainButtonDef`, no declared incompatibility** (which is the evidence for `settings_audit: not_applicable`). |
| XML checkers | the collection's `scripts/Check-XmlFields.ps1`, `Check-XmlClasses.ps1`, `Check-DefRefs.ps1`, `Check-DefInjected.ps1` | Unknown fields, unresolved classes, unresolved def references, DefInjected paths. |
| Vocabulary check | `Tests/Pickle/Check-Steps.ps1` | Before any ticket: every step line of every feature matches exactly one expression among the suite's and Pickle's own; the pass maps end with a newline. It has been seen failing on an invented step. Vocabulary only, not the logic behind a step: a code review on 2026-09-28 found that "holds N manure" raced DBH's own fermentation timer (fixed below, see `docs/runs/2026-09-28.md`). |
| Pickle suite | `Tests/Pickle/` | What needs a running game, listed next. |

### What only a running game shows, and so is in Gherkin

| Feature | Scenario | Why it needs the game |
| --- | --- | --- |
| `01-architect-and-work` | The Hygiene architect tab groups the two composters under one button | The dropdown is built from the resolved designators of the category, after every patch of the real load. |
| `01-architect-and-work` | A colonist finds the manure composter and fills it | The whole reason the mod ships an assembly is that DBH's WorkGivers only ever see their own building. Only a pawn scanning a real map shows that the second composter is seen. |
| `01-architect-and-work` | A finished composter is emptied by a colonist and yields biosolids | The development control (our translated override), DBH's unload job and the product, end to end. |
| `02-save-and-reload` | A composter keeps its contents through a save and a reload | The subclass must not disturb DBH's own Scribe fields. |
| `03-review-inspect-text` (`@review`) | The inspect pane and the development control speak the language of the game | A person reads two captures per language: raw keys, accented fallback, clipping. |
| `04-fertile-fields` (`@requires:jamaicancastle.RF.fertilefields`) | The two compost recipes are patched by this mod | Attribution in a real load with the real Fertile Fields. |

### What is deliberately not in Gherkin, and why

These rows of `TEST_SCENARIOS.md` end as *not applicable*, each with its reason, so nothing is left as a manual test:

- **Job restrictions, cold and ruin** (forbidden, reserved, on fire, marked for deconstruction, below -18 or above 58 degrees,
  freezing and overheating messages). The mod inherits `HasJobOnThing`, `CompProperties_TemperatureRuinable` and the ruin logic from
  Dubs Bad Hygiene and vanilla unchanged; it overrides one property of the scan. Testing them would test the engine and DBH, not
  this mod (`AUDIT.md`, "On ne teste pas le jeu"). What the mod declares, the temperatures in its def, is checked offline.
- **The ordinary DBH composter still works.** DBH's own code. What this mod does to it, adding it to the dropdown, is in
  the first scenario above.
- **Bill ingredient lists at a workbench.** The patch outcome is asserted offline against the real Fertile Fields defs with the game's
  own patch engine, and in a real load by scenario `04`. The ingredient window is Fertile Fields' and vanilla's.
- **Old saves and an upgrade path.** No earlier public version exists: `0.1.0` created a private item with the same content, and no
  save has ever held another version. Nothing to upgrade from.
- **A real restart between a write and a read.** The mod owns no serialized field; the two it saves are DBH's, and scenario `02`
  reloads them in process. A restart would add nothing the mod owns.
- **Burn It for Fuel.** The installed `JPT.BurnItForFuel` declares 1.1 to 1.3 and cannot load in 1.6. **Two 1.6 successors exist, found on 2026-09-28
  on their Steam pages and not yet inspected**: Mlie's deprecated "(Continued)" (`3004932466`, declares 1.6) and jptrrs's rewrite "Burn It for Fuel 2"
  (`3553442151`, 1.6, a different design with a per-building fuel tab). Whether either keeps the def `BurnItForFuel` and the storage filter the patch
  targets is unknown, so the patch may be inert or aimed at the wrong mod. Until `BACKLOG.md` is done, the patch is exercised only against a synthetic
  target in the offline contracts, and the live scenario is **unverified**, not justified as not applicable.
- **Settings, MainButtons shortcut, RIMMSQOL.** The mod has none (offline check above): no page, no shortcut, no integration to claim.
- **DLC absent, declared incompatibility.** The mod uses no DLC and declares no `incompatibleWith`.

## Passes

The suite is a companion mod, `nelim.manurecomposting.pickletests`, in `Tests/Pickle/Mod`. Its only step assembly is built from
`Tests/Pickle/Source` and committed, since the WSL staging copies the folder as it is:

```powershell
dotnet build Tests/Pickle/Source/ManureComposting.PickleSteps.csproj -c Release
powershell.exe -ExecutionPolicy Bypass -File Tests/Pickle/Check-Steps.ps1
```

| Pass | Map | Language | Features played | What it establishes |
| --- | --- | --- | --- | --- |
| minimal-en | none (bare pass) | English | 01, 02, 03 (04 skips: Fertile Fields absent) | The mod and its two hard dependencies work alone, and load cleanly without Fertile Fields |
| minimal-fr | none (bare pass) | French | 01, 02, 03 | The same in French; the inspect text and the development control read as translated |
| avec-fertilefields | `wsl-deps.avec-fertilefields.map` | English | 04 (`-Filter 04-fertile-fields`) | The one optional integration claimed, beside the real Fertile Fields |

`wsl-ids.map` gives the Workshop ids of the two hard dependencies the shared staging table does not know (Burok's Manure, Dubs Bad
Hygiene). It is read in every pass and activates nothing by itself. Each pass is one request to the queue: the mod is staged when its
ticket is played, from the working tree of that moment, so the SHA of the tested revision goes in the `-Label`.

```powershell
powershell.exe -ExecutionPolicy Bypass -File C:\Users\nelim\Documents\rimworld\Rimworld-Ticket-Dispatcher\scripts\Submit-PickleRun.ps1 `
  -Mod ManureComposting -Owner local_<session id> -Label "minimal-en <sha>" `
  -EvidenceDir ManureComposting/Tests/Pickle/Evidence/<date>-minimal-en
```

Add `-Language French` for the second pass and `-DepMap wsl-deps.avec-fertilefields.map -Filter '04-fertile-fields'` for the third.
A first exploratory ticket may play one scenario only (`-Filter '::a colonist finds the manure composter and fills it'`) to learn the
fixture: the cells used, the temperature of the test colony, the hauling priority.

## Conditions to reach `tested`

All of these, on the revision being tested (`AUDIT.md`, step 9):

1. The three passes above have run and each report was read, `exitReason` first, then the count of scenarios played against the
   features discovered. A report whose `setName` or suite name is not this mod's is not evidence: the report folder is shared by the
   whole machine.
2. **No scenario is left in `@wip`.** A scenario put aside is either repaired and replayed, or deleted with its reason written here.
3. **Every conditional scenario has run.** `04-fertile-fields` carries `@requires:jamaicancastle.RF.fertilefields`: it counts only in
   the pass that stages Fertile Fields (`avec-fertilefields`), where its report was read. A scenario skipped for want of its condition
   is not a scenario passed.
4. **No manual test remains to validate.** Every row of `TEST_SCENARIOS.md` is either automated and green, or listed above as not
   applicable with its reason. The `@review` captures are still opened and read by a person, but that is reading an image a scenario
   has already proved to be in the wanted state, not one more manual test.
5. English and French each read: `03-review-inspect-text` opened in both passes, checking for raw keys, accented fallback text and
   clipping.
6. The startup `Player.log` of each pass checked: no error from this mod, and no unresolved def or translation.

## Evidence: what to keep, what to delete

Evidence stays on disk and out of git (`Tests/Pickle/Evidence/`, `Tests/Results/`, `evidence/` are ignored, as are `*.dds`). A Pickle
report is tens of megabytes and the shared report folder holds every mod's screenshots, so nothing is copied whole.

**Kept, per pass**, in `Tests/Pickle/Evidence/<date>-<pass>/`: `summary.md` and `summary.json`, `junit.xml`, a `log-check.txt` (the result of
searching `Player.log` for `^(XML error|Config error|Could not resolve|Could not find)` and for `exception`, both expected to be 0), and
for the two `@review` scenarios a **JPEG** of each capture (1280 px wide, about 100 KB), four in all: the composter filling and composted,
in English and in French. One line per run in `docs/runs/`, with the game build read from the first `RimWorld` line of `Player.log`.

**Deleted**: the PNG captures once their JPEG exists, `report.html`, `messages.ndjson` once the verdict is written, `Player.log` (it carries the
home path of the machine), a `screenshots/` folder copied whole, the report of a failed or infrastructure attempt once its cause is written in
`STATUS.md` and its line is in `docs/runs/`, and any report on a superseded build once the pass has been repeated on the current one. A report that
is the only proof of a check the newer run did not repeat stays. Never delete a report a `STATUS.md` field points to: repoint the field first.

**Kept offline**, in `Tests/Results/`: the latest output of each offline test (`runtime-contracts.txt`, `text-adapter.txt`, `resources.txt`,
`xml-checks.txt`), the hashes of the delivered files (`artifact-hashes.csv`) and the art check (`art-qa.json`). Each rerun replaces the previous
file: an older result of the same test proves nothing about the current build.

## Offline results

The latest run, on the delivered build, is written in [docs/runs/2026-09-28.md](docs/runs/2026-09-28.md). Reproduce with:

```powershell
pwsh -NoProfile -File Tests/Test-RuntimeContracts.ps1
pwsh -NoProfile -File Tests/Test-TextAdapter.ps1
python Tests/test_resources.py
```

Run each script in a fresh process: they load different test assemblies. The runtime scripts accept `-Workshop`; the first also accepts
`-GameRoot`. Dependency resources stay local and are not redistributed with the tests. The four XML checkers need the installed game and
dependencies and are not vendored; their parameters are in `docs/runs/2026-09-28.md`.
