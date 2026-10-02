---
localization: complete
translation_en: complete
translation_fr: partial
settings_audit: not_applicable
mod:          Manure Composting
packageId:    nelim.manurecomposting
repo:         Rimworld-Manure-Composting
visibility:   public
detached:     yes
stage:        done
workflow_stage: done
licence:      open
licence_at:   MIT for own implementation and artwork; runtime dependencies are not redistributed
upstream_mod_remotes:
  - https://github.com/Burakyilmam/Manure (Burok.Manure, source only, no LICENSE file, found 2026-09-28)
dependencies: declared
showcase:     complete
tested_on:
workshop:     3806768526 (private item "Manure Composting", visibility hidden, published 2026-09-23 16:46; opened on Steam 2026-09-28, description matches About.xml)
remaining:
  - unverified: Re-run avec-fertilefields after the 2026-09-29 feature-file fix (Tests/Pickle/Mod/Pickle/Features/04-fertile-fields.feature: the "was patched by mod" step takes the mod's display Name, not its packageId, same quirk as ColorfulCoatsMegafaunaRenew; no ticket filed since the fix). The 2026-09-28 run failed both lines on the old packageId argument, not a patch defect — the failure message itself showed the patch applied and was attributed to this mod. minimal-en and minimal-fr both ran 2026-09-29: 5/6 passed each, 1 skipped as expected (Fertile Fields absent).
  - unverified: Open and read the @review captures of a green avec-fertilefields pass (that pass covers feature 04 only, no filling/composted captures of its own). The English and French pairs were read 2026-09-29, both clean.
  - unverified: Read the startup Player.log of a green avec-fertilefields pass; no error, unresolved def or translation from this mod. minimal-en and minimal-fr logs were read 2026-09-29, nothing traced to this mod (minimal-fr's "77 translation errors" warning checked and traced to other mods/base game, not this mod's keys).
  - unverified: Burn It for Fuel has two 1.6 successors (Mlie's Continued 3004932466, Burn It for Fuel 2 3553442151), neither installed nor inspected; the patch may aim at neither (BACKLOG.md).
  - unverified: French review by Virginie. FRENCH_REVIEW.md generated 2026-09-30 from the working tree; every French file was read in full and none needs the {PAWN_gender ...} switch (no text agrees with a pawn). No session marks its own French reviewed.
session:      local_b08654aa-d51f-4735-9269-5535095b95bf
updated:      2026-10-02, AUDIT.md reapplied: evidence on disk minified (41 MB to 0.5 MB), no .dds anywhere (ignored), PROTOCOLS-READ.md and TESTING.md pass order refreshed; stage unchanged, nothing ran in game
---

# Manure Composting - status

Kept at the root, never inside `Mod/`, so Steam never receives it. Maintained by the session that holds this mod.

## Where it stands

`stage` is **done**: the offline tests were replayed and are green, and the Pickle suite is written and justified. **Nothing has run in a game**, so `tested` is
not claimed and `tested_on` stays empty. The repository is standalone (`origin` is `https://github.com/vbardales/Rimworld-Manure-Composting`, public, the only
remote). A private Workshop item exists (`0.1.0`, `Mod/About/PublishedFileId.txt`); `1.0.0` stays unreleased above it in the CHANGELOG.

`stage` codes, as `AUDIT.md` step 12 defines them: `port` before `horsMonoRepo`; `showcase` from `Preview générée` to `l10n`; then `preTest`, `done`, `tested`,
`published`. `prepublished` has no code of its own: it is recorded in `workflow_stage` when it applies.

## Audit of 2026-09-28

Audited on `68aa615` plus the working-tree changes of the day. **Entry state: `preTest`, not the `done` this file declared**, because `preTest -> done` failed: no
`Tests/Pickle/`, no `TESTING.md`, and no sentence justifying the absence of Pickle suites (`AUDIT.md`: silence is not a justification). Every transition before it held.
The defect was then corrected in the same session, by the session that holds the mod, and the transition was audited again: `done`.

| Transition | Result | Evidence |
| --- | --- | --- |
| dansMonoRepo -> horsMonoRepo | Validated | Own git repository on `main`, one remote, GitHub repository public; STATUS, README, ATTRIBUTION, LICENSE, CHANGELOG in English; the copies in `Mod/` equal the root ones |
| horsMonoRepo -> ModIcon | Validated | `Mod/About/ModIcon.png` 128x128, 22204 bytes; original in `Art/ModIcon-original.png`. Not regenerated (owner's job only) |
| ModIcon -> Preview | Validated | `Mod/About/Preview.png` 896x504, 561109 bytes, under 1 MB |
| Preview -> preOptions | Validated | Description in English; ends with `[url=...]Source code on GitHub[/url]` to the exact repository (`test_resources.py`); name has no prefix, suffix or linking word to treat |
| preOptions -> options | Validated, `not_applicable` | No settings class, no `MainButtonDef`, no declared incompatibility, executable in `test_resources.py` (91 checks) |
| options -> l10n | Validated against the current TRANSLATIONS.md | Two Keyed keys per language, nine owned Def fields in French, parameters and DefInjected paths checked. **Plurals (rule of 2026-09-25):** the only number shown through a key is `MC_ContainsManure` (`{0}/{1}`, an amount of a mass noun over a capacity), not a counted noun phrase, so it needs no `.One` and `.Many` |
| l10n -> preTest | Validated | `modDependencies` are Burok.Manure and Dubwise.DubsBadHygiene, both with Workshop ids; `loadAfter` names Fertile Fields and Burn It for Fuel; no `LoadFolders` and none needed; the optional patches are guarded on the def. Redone on 2026-09-28 by reading `About.xml`, the defs and the patches |
| preTest -> done | **Failed at entry, corrected, validated** | Offline tests replayed 2026-09-28 (details in `docs/runs/2026-09-28.md`); the DLL rebuilds byte-identical; the Pickle suite is written in `Tests/Pickle/` with its scope justified in `TESTING.md`, its vocabulary checked offline |
| done -> tested | Not started | No game run. Conditions in `TESTING.md` (no `@wip`, every conditional scenario run, no manual test left) |

## Publication state

The private item was created by the `0.1.0` prepublication on 2026-09-23 at 16:46, the time of `Mod/About/PublishedFileId.txt` and of the Steam page; its content is `Mod/` as of commit `0095f75`.
That commit is inferred from the file time, not recorded when the upload was made. `Mod/About/PublishedFileId.txt` is committed (`68aa615`). The item stays private until the owner
makes it public, and this is not the `prepublished` state of the chain, which needs `tested` first.

## Origin of the code

The mod is an original creation: nothing is copied from another mod (`ATTRIBUTION.md`). Velcroboy's Manure (1.3 and 1.5, dead) was read for the idea, and Burok's
Manure and Dubs Bad Hygiene are hard dependencies loaded from the player's copy. **Burok's Manure has a source repository**, `https://github.com/Burakyilmam/Manure`
(user-supplied link, found 2026-09-28, confirmed by its README: credits Burok, links Workshop item 3784198780), source only, no `LICENSE` file. Read
in full on 2026-09-28: no overlap with this mod, which only names `Manure` and `DryManure` by defName; `PUBLISHING.md`'s pull-request rule finds
nothing to propose there (`BACKLOG.md`). No repository is known for Velcroboy's Manure, whose Steam page and local `About.xml` link none.

## Evidence

Nothing is tracked (no .dds, no report in the index; *.dds, `Tests/Pickle/Evidence/`, `Tests/Results/` and `evidence/` are ignored). Minified on disk 2026-10-02: `Tests/Pickle/Evidence/2026-09-28-minimal-en` and `-minimal-fr` keep summary, junit, `log-check.txt` and the two `@review` captures as JPEG; `2026-09-28-avec-fertilefields` keeps summary, junit and log-check only (failed run, superseded by the pending re-run). `docs/runs/2026-09-29.md` is the text record. No `pickle-reports-archive/` folder belongs to this mod.

## Documents read

`docs/PROTOCOLS-READ.md` lists each protocol read on 2026-09-28, its version, and the ones that were not useful.

## Field vocabulary

`stage`: `port`, `showcase`, `preTest`, `done`, `tested`, `published`. `done` means the work is finished and ready for in-game validation, not that it is published.

`licence`: `open` an explicit licence, `silent` no licence and a dead source, `alive` no licence but a living source, `forbidden` a written refusal, `original` owing nothing
to anyone (not even an idea traceable to one mod). **`open` is kept as the earlier session set it**: the mod ships an explicit MIT licence. `original` is ruled out by its own definition, since the idea comes from reading Velcroboy's Manure; nothing is owed, nothing being reused.

`remaining`: `feature` for something missing from a first release, `defect` for a known fault left unfixed, `unverified` for what could not be checked.

---

# Earlier status, replaced on 2026-09-28

Kept as written. It said `done` on the strength of the offline tests and had no Pickle suite; the section above supersedes its gate table and its
pointers to `Tests/Results/`, which is no longer tracked.

# Current status — fixes validated on 2026-09-13

**done** means ready for final functional validation in game, not already tested in game.
It is the literal code from the supplied workflow. All preceding cumulative gates are now
established. The fixes are committed and pushed (origin/main 0095f75, 2026-09-20). A Workshop item id is present locally, see `workshop`.

| Gate | Current result |
| --- | --- |
| horsMonoRepo | Independent public GitHub repository and initial pushed commit validated in the preceding audit; naming, English documentation and MIT boundary remain coherent. |
| ModIcon generated | Correct 128x128 PNG installed, 22204 bytes; original preserved in Art/ModIcon-original.png; 32px visual review passed. |
| Preview generated | Built-in image generation, source Art/Preview.png; final Mod/About/Preview.png is 896x504 and 561109 bytes. Direct visual review passed. |
| preOptions | English description ends with exact GitHub source link. Title matches About; no prefix/suffix/linking-word treatment applies. Preview composition, accent distinction and contrast passed. |
| options | settings_audit not_applicable reconfirmed: scan/text adapters add no user settings, empty page or MainButtonDef. No independent settings are useful; gameplay and DBH controls already own the choices. |
| l10n | Complete owned EN/FR coverage and parameter/DefInjected checks; inherited composting text traced against installed DBH and vanilla. |
| preTest | Mandatory DBH/Manure and optional FF/burner declarations/guards coherent; current classes/fields/Def references pass. |
| done | Written functional scenarios plus passing automated and XML tests; delivered DLL rebuilt. See Tests/Results/README.md and artifact-hashes.csv. |
| tested | Not verified: no interactive game or save tests executed. |

## Changes and evidence

- Corrected nine owned French Def fields and added two EN/FR Keyed strings.
- Corrected the shared DBH French loading/unloading reports in this mod's language
  resources. This intentionally also improves DBH's own composter reports while this
  mod is loaded; installed Workshop files were not edited.
- Added Building_ManureComposter, a text-only subclass: unfinished contents correctly say
  manure, and the inherited development control is translated while retaining its action.
  DBH still owns composting, temperature behavior and serialization; no saved fields added.
- Corrected the cold-temperature description to match actual DBH behavior.
- Kept build intermediates in the standalone repository instead of its parent.
- Added TEST_SCENARIOS.md, test scripts and captured test results. Build passed with zero
  warnings/errors; 40 actual patch/WorkGiver checks, 20 text-adapter unit checks and 88
  resource/packaging checks passed. All XML checks passed (see documented advisory limits).
- DLL SHA256: FAA8958242B5F88768A2024A45E8796F72B18602B4675A9F8E2EB320CC079C62.

## Visual evidence

Art/GENERATION.md contains the exact built-in generation prompt. The scene is a high
oblique view of a compost yard, with a clearly readable compost bin and no faces.
Art/preview-palette.json is the sole palette source used by Art/preview.html and
Art/render.cjs. The slate ground supplies the veil/dominant family and pale blue secondary
ink; the warm wooden rim/lamp pool supplies the distinct golden accent. No status tag is
required, so secondary ink is defined but no unnecessary tag is rendered.
Segoe UI regular and semibold are installed; no fallback used. Minimum rendered-background
contrast is 6.73:1 for title, 7.08:1 for summary, 8.70:1 for badge. Source/final/268px Preview
and 32px icon were directly inspected: title, version, accent rule and subject remain clear,
with no overlapping/cut text or concrete camera defect.

## Settings and translation evidence

Source inventory now includes the building text adapter, the two WorkGivers and cached
Def lookup. No ModSettings/Verse.Mod settings page or MainButtonDef exists. Settings
persistence and RIMMSQOL shortcut tests are not applicable; no such integration is claimed.

Owned English uses native Def values plus two Keyed resources; French covers all nine
owned paths from the historical inventory, plus two shared JobDef report corrections.
The new keyed entries are MC_ContainsManure ({0}/{1}) and MC_DebugFinishComposting.
DBH Building_Composter, both WorkGivers and vanilla CompTemperatureRuinable were traced
locally to identify inherited text: compost/sludge quantities, progress, temperature,
nonideal temperature, material/temperature failure reasons, freezing/overheating/ruin and
job reports. Used DBH EN/FR placeholders and vanilla keys are verified by test_resources.py.
The only hardcoded development-label literal in our source is a match against DBH's label;
it is replaced with the translated string before display. Ordinary engine-owned building
commands and user-entered names retain their native translation/user-data mechanisms.

No in-game display or persistence claim is made. Local tests use the actual patch engine
and WorkGiver assembly where possible, and an explicitly documented base test double for
the text adapter where Unity prevents headless building construction.

# Historical audit — before these fixes

The following records describe the pre-fix state and remain for provenance. Their failed
criteria and old status statements are superseded by the current section above.

# Audit — 2026-09-13

## Scope and conclusion

Standalone repository: `C:/Users/nelim/Documents/rimworld/ManureComposting`.
Distributed root: `Mod/`; source: `Source/`. Revision:
`621eb1f403c89f6ebc1cd682873148df1befcea8`, plus the pre-existing untracked
`Mod/About/ModIcon.png` and `STATUS.md`. No source, distributed artefact or history was changed.
Audit build output is isolated under ignored `.build/audit/`.

`stage: horsMonoRepo` uses the exact supplied workflow name, not a legacy code.
Order: dansMonoRepo -> horsMonoRepo -> ModIcon generee -> Preview generee ->
preOptions -> options -> l10n -> preTest -> done -> tested.
The first incomplete transition is horsMonoRepo -> ModIcon generee.
Later independent checks below do not raise the cumulative stage.

Read the parent AGENTS.md, PUBLISHING.md, STYLE_RIMWORLD.md, MOD_SETTINGS.md and
TRANSLATIONS.md. The supplied request overrides the older settings requirement for
in-game checks before options: runtime validation belongs to done -> tested.

## Ordered transition results

| Transition | Result | Evidence / blocking criterion |
| --- | --- | --- |
| dansMonoRepo -> horsMonoRepo | Validated | Actual standalone Git root; origin points to the exact GitHub repository; live GitHub visibility PUBLIC; remote HEAD equals local revision above. English README, ATTRIBUTION, LICENSE and CHANGELOG exist. Distributed LICENSE and ATTRIBUTION are byte-identical to root copies. Package ID, name, folder and repository are coherent. |
| horsMonoRepo -> ModIcon generee | Defect found | Implementation is present and build passes with an identical shipped DLL. PNG is directly inspected but 1254x1254, 1,362,296 bytes instead of 128x128. Its single orange mascot and compost subject are identifiable; no generation-history requirement was imposed. Final 32px readability was not tested. |
| ModIcon generee -> Preview generee | Defect found | Mod/About/Preview.png does not exist. No visual inspection or camera judgment is claimed for it. |
| Preview generee -> preOptions | Defect found | Preview palette/typography cannot be checked. English description and title exist, but the description ends with credits instead of [url=https://github.com/vbardales/Rimworld-Manure-Composting]Source code on GitHub[/url]. The separate url field matches origin but does not satisfy this gate. The name has no linking words or extension suffix requiring special treatment. |
| preOptions -> options | Independently validated: justified non-applicability | See Settings audit. |
| options -> l10n | Defect found / partially unverified | Nine owned French fields missing; inherited UI inventory not fully traced. See Translation audit. |
| l10n -> preTest | Dependency declarations independently validated | Manure and DBH are real hard dependencies; Fertile Fields and Burn It for Fuel are optional, loadAfter-only integrations with conditional patches. See dependency evidence and limits below. |
| preTest -> done | Not verified | Existing shared XML checks were executed and passed, but no written functional scenarios or behavioral test suite was found. Compilation/XML checks do not establish WorkGiver, composting or optional-patch behavior. No blanket non-applicability is claimed. |
| done -> tested | Not verified | No in-game scenario, log review, EN/FR UI or new/existing-save validation was performed. No customization integration is claimed as tested. |

## Repository and licence evidence

`git rev-parse --show-toplevel`, `git remote -v`, `git log -1`,
`git ls-remote origin HEAD` and
`gh repo view vbardales/Rimworld-Manure-Composting --json nameWithOwner,visibility,url`
were checked. The remote is public and its HEAD is the audited commit.
Initial sandbox network/config restrictions were overcome by authorized read-only execution.
No push or publication was performed. The monorepo remote is irrelevant to this gate.

The previous `licence: original` wording claimed no traceable idea from another mod,
while ATTRIBUTION explicitly credits Velcroboy for the composter idea and integration list.
The audit uses `open` for the existing explicit MIT licence on this implementation;
this does not assert MIT rights over dependency code or textures. The small C# adapter,
Defs and patches reference DBH/Manure at runtime; no dependency DLL or texture ships here.
Credits and the removal commitment remain intact. No new third-party licence is invented.

## Build and XML checks actually executed

- `dotnet build Source/ManureComposting.csproj -p:BaseIntermediateOutputPath=C:/Users/nelim/Documents/rimworld/ManureComposting/.build/audit/obj/ -p:OutputPath=C:/Users/nelim/Documents/rimworld/ManureComposting/.build/audit/bin/ --ignore-failed-sources`: PASS, zero warnings/errors. Initial sandbox attempt failed on SDK directory access (MSB4184); rerun with SDK access succeeded.
- SHA256 of both rebuilt and distributed ManureComposting.dll:
  `FE3BB54C6EAC6E439EB2A9F5562BAFB4C0CE811FBFC1815E0674B0CC5B7B21AA`.
- Parsed all six distributed XML files: PASS.
- `../scripts/Check-XmlFields.ps1 -ModPath <repo>/Mod -ExtraAssemblies <DBH 1.6>/Assemblies/BadHygiene.dll,<repo>/Mod/Assemblies/ManureComposting.dll`: PASS, six files, no unknown fields against installed RimWorld 1.6 assemblies.
- `../scripts/Check-XmlClasses.ps1 -ModPath <repo>/Mod -TypeLists ../rw16_types.txt,.build/audit/dbh-types.txt -SourceDirs <repo>/Source`: PASS, nine referenced types resolved. DBH type list generated from installed DLL by reflection; the shared vanilla list is an existing reference list, not freshly generated.
- `../scripts/Check-DefRefs.ps1 -ModPath <repo>/Mod -AlsoScan <Workshop>/836308268/1.6,<Workshop>/3784198780,<Workshop>/3225843229/1.6`: PASS, four owned Defs, well-formed XML, no missing/wrong-type references or unresolved parents.
- `Check-DefInjected.ps1`: not applicable to current files because no Languages/DefInjected resources exist. This is NOT a French coverage pass.

`<Workshop>` is `C:/Program Files (x86)/Steam/steamapps/workshop/content/294100`.
The scripts above are shared parent-repository tools, not a self-contained test suite
shipped in this standalone repository. Historical README results remain below and were
not substituted for current executions. XML validators do not execute the game patch pipeline.

## Settings audit

Result: `not_applicable`, established from both C# files, the project and all distributed
Defs/patches. The code only caches the composter Def and overrides the fill/unload scan target.
There is no Verse.Mod subclass, ModSettings, settings serialization, settings UI or
MainButtonDef. It creates neither an empty settings page nor a shortcut.

The useful choices are already ordinary gameplay choices: build/use the composter versus
letting manure dry, and recipe ingredient selection in Fertile Fields bills. Temperature,
capacity, progression and job behavior are supplied by DBH; this adapter adds no independent
simulation settings or documented user configuration requiring XML editing. Fixed building
costs and WorkGiver priorities are balance data, not a reason to invent an options page.
Options persistence, input limits and RIMMSQOL shortcut tests are therefore not applicable
for this mod. No DBH settings UI or customization integration was interactively tested.

## Translation audit

Owned C# has no displayed literal text. All owned text uses native Def fields with nonempty
English source values; no redundant English language folder is needed. English coverage of
the nine owned fields is complete. French has no language resources at all and is incomplete.
Required paths, grouped by Def type:

- DesignatorDropdownGroupDef: `Nelim_Composters.label`.
- ThingDef: `Nelim_ManureComposter.label`, `Nelim_ManureComposter.description`.
- WorkGiverDef: `Nelim_FillManureComposter.label`, `.verb`, `.gerund`.
- WorkGiverDef: `Nelim_UnloadManureComposter.label`, `.verb`, `.gerund`.

The intended injection paths correspond to fields accepted by the XML field check; actual
French injection and parameter parity cannot be validated without resources. The owned
fields have no substitution parameters; the building description uses native literal \n
line breaks. Patches add only Def references, not text. About metadata and repository
licensing/documentation are outside the in-game translation inventory.

DBH owns inherited inspect strings, failure reasons and job reports. Installed French keyed
resources include ContainsCompost {0}/{1}, CompostingProgress {0} ({1}), Composted and
NoCompostingMaterial. However, its French DefInjected/JobDef/Jobs_Hygiene.xml contains
`UnloadComposter.reportString = defequer TargetA.` (accented in the file), an incorrect
meaning for unloading compost, reused by the inherited job. This is an upstream text defect,
not a newly owned key. Full tracing and EN/FR parity of inherited UI and runtime rendering
remain unverified; `localization: partial` makes this limit explicit.

### French gender agreement and systematic review (2026-09-30)

All nine owned French fields (the paths listed above) and both inherited DBH JobDef
reportStrings this mod's French DefInjected overrides (`LoadComposter.reportString`,
`UnloadComposter.reportString`) were read in full — every French file the mod ships, not a
pattern search: `Mod/Languages/French/Keyed/ManureComposting.xml` and the four
`Mod/Languages/French/DefInjected/**/*.xml` files. None contains text that agrees with a
pawn (no adjective, past participle or noun describing a pawn): every owned and inherited
string names a building, a job action or a quantity, not a person. The three-segment
`{PAWN_gender ? ... : ... : ·...}` switch from TRANSLATIONS.md therefore applies to nothing
in this mod — not a gap, an absence of the trigger condition.

`FRENCH_REVIEW.md` was generated by `_tools/Generate-FrenchReview.ps1` (reads the shipped
XML directly; Original = English throughout, this mod has no other source language) and
confirms no French text flags a `{PAWN_gender` marker. `translation_fr` moves to `partial`,
not `complete`: only Virginie's own reading of `FRENCH_REVIEW.md` can close it. Until then
`remaining` carries "French review by Virginie" as `unverified`.

## Dependencies and runtime limits

Installed About.xml checks confirm DBH packageId Dubwise.DubsBadHygiene, modVersion 3.1.2800,
with 1.6 support; Manure packageId Burok.Manure with 1.6 support; Fertile Fields packageId
jamaicancastle.RF.fertilefields with 1.6 support. Required IDs match modDependencies and
loadAfter. Manure declares Harmony itself; this adapter does not directly call Harmony.
DBH is required by the compiled base classes even though the relevant Defs also use MayRequire.
BadHygiene reference is Private=false; only this mod's DLL is distributed.

No LoadFolders.xml or alternate version directories exist in this mod: root content targets
1.6. Optional patches guard their actual target XPath. DBH supplies the shared dropdown
building target; the reference checks passed with installed dependencies. The dbhlitemode
research marker is conditional, not an undeclared compulsory dependency. Burn It for Fuel
support remains guarded and unexercised; historical statements that unsupported versions
cannot load are not treated as proof of runtime behavior. No optional integration or save
compatibility claim has been certified by this audit.

## Historical status (preserved)

The 2026-09-12 automatic sweep had blank stage, detached=no, licence=original,
localization/English/French unchecked, dependencies=declared, showcase=none,
empty tested_on/workshop and remaining="unverified: never seen running".
It was a declaration, not a passed audit. Its explanatory body is retained below.

# Manure Composting — status

Read by a sweep across every mod, rather than by asking each thread in turn. It lives at the
root, never inside `Mod/`, so Steam never receives it.

The fields above were read off the disk on 2026-09-12. Four cannot be, and wait for whoever
holds this mod:

- **`stage`** — one of `port`, `showcase`, `preTest`, `done`, `tested`, `published`. Filled in
  from the session group where one exists; confirm it.
- **`tested_on`** — the date of the last run in game. Empty means never.
- **`dependencies`** — `declared` when every mod this one needs is named in the About's
  `modDependencies`, `to check` when a non-vanilla `loadAfter` suggests a dependency that is not
  declared, `none` when the mod needs nothing. An undeclared dependency is not cosmetic: on
  2026-09-11 Reequilibrage animaux took 47 vanilla animals down with it, Muffalo included, because
  the class it injects belongs to a mod that was not declared and not loaded.
- **`remaining`** — what is left, in three kinds: `feature` for something missing from a first
  release, `defect` for a known fault left unfixed, `unverified` for what could not be checked.
  The line already there is true of nearly the whole repository; replace it once it stops being.

`licence` vocabulary: `open` an explicit licence, `silent` no licence and a dead source,
`alive` no licence but a living source, `forbidden` a written refusal, `original` owing nothing
to anyone — not a name, not an idea traceable to one mod, not a value derived from its assets.

