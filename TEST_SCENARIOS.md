# Functional validation scenarios

All scenarios are **NOT RUN IN GAME**. Record date, game/dependency versions, mod-list,
language, save identity, steps, observed result and Player.log for each execution.
Use a disposable new colony and a COPY of an existing save; never overwrite the original.

Common prerequisites: RimWorld 1.6, Harmony as required by Manure, Burok.Manure,
Dubwise.DubsBadHygiene, then nelim.manurecomposting. Use the DLL and file hashes in
Tests/Results/artifact-hashes.csv. Test English and French in separate fresh launches.

| Scenario | Preconditions | Actions | Expected result |
| --- | --- | --- | --- |
| Load and build | New colony; dependencies enabled; steel available; hauling enabled | Open Hygiene architect tab, expand composters, inspect both Defs and build a manure composter | Both composters share the dropdown; manure composter costs 45 steel; translated name/description; no missing class/Def/texture or translation errors |
| Full production | Built composter at 21 C; fresh Manure in reach; pawn can haul | Fill in two batches; inspect count/progress; allow normal progression; unload when finished | Only fresh Manure is consumed; added material dilutes progress; output is Biosolids, not manure or fuel; progress and input count reset after unloading; ordinary DBH composter still works |
| Job restrictions | Empty/partly filled composter and reachable fresh manure | Forbid, reserve with another pawn, mark for deconstruction, set on fire; remove each restriction; test below -18 C and above 58 C | Loading is rejected for each applicable restriction, resumes when clear; translated temperature/no-material reasons; no errors; full/finished composters are not loaded |
| Cold and ruin | Filled composter, stable room temperature | Compare progression at 21 C and 0 C; then expose below -20 C or above 60 C long enough | Cold slows progression; extreme temperature can ruin/reset contents; translated freezing/overheating/ruin messages; UI must not claim a hard cold stop |
| English/French text | Fresh launch in each language; filled, finished, empty and minified composters | Inspect states and pawn reports; enable dev mode and use finish-composting control once | Unfinished contents say manure/fumier, not sludge; counts and progress are formatted; unloading says remove compost, not defecate; development control is translated and still finishes progress; no raw keys or clipped labels |
| Save and upgrade | Copy of existing save (include old-version manure composter if available), plus new test colony | Install corrected version, load, fill partly, save to new slot, quit/relaunch, reload; minify/reinstall a composter | Def identity preserved; old DBH wortCount/progress state preserved by inherited serialization; job scanning still finds building; no migration exception. Remove only after deconstructing all manure composters |
| Fertile Fields present/absent | Run once without FF, once with installed FF before this mod | Create MakeCompost and MakeCompost5 bills, inspect ingredient lists and perform a bill | No patch errors without FF; with FF both fresh/dry manure accepted; only dry manure enabled by default; fresh may be enabled explicitly; biosolids-to-fertilizer recipe is not bypassed |
| Burn It for Fuel | Only if a compatible 1.6 target is available | Inspect burner storage filter and haul dried manure | Dried manure accepted. If no compatible target exists, record this live scenario as not applicable with the actual mod-list; synthetic patch tests do not certify a continuation |
| No settings / regressions | Clean configuration without RIMMSQOL | Open Mod options and inspect main buttons; operate normal DBH composter | No empty settings page, visible or greyed-out shortcut introduced by this mod; DBH settings remain DBH-owned; both composters still work |

After every scenario inspect Player.log for errors, missing translations/Defs, exceptions
and repeated messages. Re-run affected scenarios after any correction. A successful
headless test or build does not fill the observed-result column for these scenarios.
