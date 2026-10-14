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
workflow_stage: playTests[1.0.0]
licence:      open
licence_at:   MIT for own implementation and artwork; runtime dependencies are not redistributed
upstream_mod_remotes:
  - https://github.com/Burakyilmam/Manure (Burok.Manure, source only, no LICENSE file, found 2026-09-28)
dependencies: declared
showcase:     complete
tested_on:    2026-10-14 (Pickle, headless WSL, RimWorld 1.6, f4af871: minimal-en 5+1 skipped, minimal-fr 5+1 skipped, avec-fertilefields 1/1; `docs/runs/2026-10-14.md`)
workshop:     3806768526 (private item "Manure Composting", visibility hidden, published 2026-09-23 16:46; opened on Steam 2026-09-28, description matches About.xml)
remaining:
  - unverified: avec-fertilefields re-run is green (2026-10-12, ticket 20261012-050740-030-23e9, label 74a817b, 1/1: both compost recipes patched by this mod); its Player.log was read, nothing traced to this mod (`Tests/Pickle/Evidence/2026-10-12-avec-fertilefields/log-check.txt`). That pass covers feature 04 only and has no @review capture, so there is nothing to open. Kept as a record until the next commit; no further action.
  - unverified: Burn It for Fuel has two 1.6 successors (Mlie's Continued 3004932466, Burn It for Fuel 2 3553442151), neither installed nor inspected; the patch may aim at neither (BACKLOG.md).
  - unverified: French review by Virginie. FRENCH_REVIEW.md generated 2026-09-30 from the working tree; every French file was read in full and none needs the {PAWN_gender ...} switch (no text agrees with a pawn). No session marks its own French reviewed.
session:      local_7facb2b3-2446-47a5-8c7e-bc19fab7f494
updated:      2026-10-14, three Pickle passes green on f4af871, code review of Mod/ diff since 91bc6e3 done
protocols_read_sha: 2f4e0002e2543fcde57999c51ff8b2f0dfc8efdb
echo_review_sha: 6c0ddf93feeaa3ea6216d5f01fb5871fa9b125e4
code_review_sha: d1b79cdbffb23d23c9e26883d72ec3fe7bb2950a
---

# Manure Composting - status

Kept at the root, never inside `Mod/`, so Steam never receives it. Maintained by the session that holds this mod.

## Where it stands

`workflow_stage` is `playTests[1.0.0]`: the three Pickle passes of `TESTING.md` ran in game on `f4af871` and are green (`docs/runs/2026-10-14.md`), the captures were opened, and the code review of 8.m covers `Source/` and `Mod/` up to `code_review_sha` (the `Mod/` diff since `91bc6e3` is a typo in the composter description and a `loadAfter` entry: no defect). What blocks `shootGallery`: the French review by Virginie (and the English reading, 8.b), and the Burn It for Fuel scenario, still unplayed.
The repository is standalone (`origin` is `https://github.com/vbardales/Rimworld-Manure-Composting`, public, the only
remote). A private Workshop item exists (`0.1.0`, `Mod/About/PublishedFileId.txt`); `1.0.0` stays unreleased above it in the CHANGELOG.

Code review refreshed 2026-10-14: revue du diff, texte seul (two description words, soil to fertiliser, in the ThingDef and About.xml).

Code review notes (2026-10-13), no change made: `Building_ManureComposter.GetInspectString` calls `Replace` on DBH's string without a null guard (DBH returns a non-empty string in the unfermented state; the pass captures show it); the development-control label is matched by its English text "Debug: Set progress to 1", so a reworded DBH label leaves the control untranslated, never broken.

`stage` codes, as `AUDIT.md` step 12 defines them: `port` before `horsMonoRepo`; `showcase` from `Preview générée` to `l10n`; then `preTest`, `done`, `tested`,
`published`. `prepublished` has no code of its own: it is recorded in `workflow_stage` when it applies.

## Audit of 2026-10-12

On `39b0f9c` (working tree: `Art/` and `Mod/About/Preview.png` modified by another job, not committed here). Vocabulary migrated: `done` is now `playTests[1.0.0]`, `stage` removed. Replayed today: `Test-RuntimeContracts.ps1` 40/40, `Test-TextAdapter.ps1` 20/20, `test_resources.py` 91/91 (run with `uv run --no-project python`), `Check-Steps.ps1` OK; `dotnet build` 0 warnings, DLL SHA256 unchanged (`FAA89582...9C62`). Hygiene (AGENTS.md, "Mod root clean"): `.build/` renamed `build/` (both `Directory.Build.props`, `.gitignore`, `Art/render.cjs`); `_tools/` deleted, `FRENCH_REVIEW.md` regenerated with the shared `scripts/Make-FrenchReview.ps1` (the 2026-09-30 reading of every French file still stands, only the generator changed); rows of `scripts/LOCAL_SCRIPTS.md` justified. Pickle: ticket `20261012-050740-030-23e9` (avec-fertilefields) ran the same day: 1/1 passed, exit 0 (evidence minified to summary, junit, log-check). Not rerun today: XML checkers (`Check-XmlFields`, `Check-XmlClasses`, `Check-DefRefs`) and the dependency, settings and translation transitions (4 to 6), kept from 2026-09-28 and 2026-09-30 and not replayed against the current protocols.

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

## Earlier records

The status written before 2026-09-28 and the audits of 2026-09-13 are in `docs/STATUS-HISTORY.md`.
