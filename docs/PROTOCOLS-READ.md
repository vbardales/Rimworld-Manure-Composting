# Protocols read

What this mod's session read, in which version, and which documents were of no use, so that a document that moves is
reread only when it mattered. Read on 2026-09-28 by the session that holds this mod. Reread a document when its
version below no longer matches, **unless it is marked not useful**, in which case reread it only when the situation
named in its line comes up.

`Version` is the last commit touching the file in its own repository, with its date. The protocol documents live in
`Rimworld-protocols`, whose git dir is `../rimworld-protocols.git` (work tree: the collection root), so the commit is read with
`git --git-dir=../rimworld-protocols.git --work-tree=. log -1 -- <file>`; a plain `git log` from the monorepo returns the commit
that removed the file. `modified` means the file differed from its last commit on disk, so the hash of the text read is given.

## Protocols

| Document | Version read | Used for | Useful? |
| --- | --- | --- | --- |
| `AGENTS.md` | `3a1d2cb` 2026-09-24, modified on disk (sha1 `ac8a0916bb`) | Evidence policy (gitignored, one line per run, never delete what STATUS points to); publication is by CI | Yes |
| `AUDIT.md` | `c5ca0c0` 2026-09-26, modified on disk (sha1 `cddbd45e13`) | The chain, every transition's criteria, the `tested` conditions, the queue and machine rules, the session title | Yes, the reference |
| `PUBLISHING.md` | `95c6dfd` 2026-09-28, modified on disk (sha1 `f915753efe`) | Upstream repository rule, the `0.1.0` prepublication and CHANGELOG shape, description and licence rules, `PublishedFileId.txt` | Yes. The animal-mod section, the GitHub topics and social preview, and the CI section are not for this stage: reread the last at `prepublished` |
| `TRANSLATIONS.md` | `f5c2d9d` 2026-09-25 | The plural rule against `MC_ContainsManure` (a mass noun over a capacity, no counted phrase, so no `.One` and `.Many`) | Yes |
| `MOD_SETTINGS.md` | `b83933b` 2026-09-23 | `settings_audit: not_applicable` and what proves it | Yes, short |
| `STYLE_RIMWORLD.md` | `7311308` 2026-09-25, modified on disk (sha1 `10238d561c`) | Only the icon and Preview controls and the Explorer folder icons | Not useful now: nothing is regenerated. Reread if the art changes |
| `WORKSHOP_COMMENTS.md` | `5dcb0c7` 2026-09-28, modified on disk (sha1 `cc8174e609`) | Nothing yet. The register has no row for Burok's Manure (3784198780) and a `drafted` row for Dubs Bad Hygiene (836308268) owned by Drum Bath Hygiene | Not useful yet. Reread at `prepublished`, before drafting thanks |
| `scripts/SEARCHING.md` | `372c447` 2026-09-23, modified on disk (sha1 `3695b05797`) | Nothing searched in the corpus. Its warning against unbounded recursive walks is a good one | Not useful. Reread if a corpus-wide search is ever needed |

## Tools

| Document | Version read | Used for | Useful? |
| --- | --- | --- | --- |
| `PickleTools/README.md` | `c771bef` 2026-09-25 | The tool table: nothing needed beyond Pickle's own steps | Yes, once |
| `PickleTools/Authoring/README.md` | `8d3ca6d` 2026-09-26 (not in the list given, read because it is the entry point for a suite) | Suite layout, pass matrix, waits and the three timeouts, C# steps, evidence | Yes, the reference for the suite |
| `PickleTools/Headless/README.md` | `ed4e73a` 2026-09-26 | Exit codes, filters, `-DepMap`, `wsl-ids.map`, `-Then`, evidence handling | Yes |
| `PickleTools/docs/steps.md` | `09f9c0e` 2026-09-28 | The vocabulary of the shared tools. Nothing in it was needed here: Pickle's own catalogue (fetched from the Pickle repository, not versioned locally) covered the suite | Not useful for this mod. Reread if a tool step is wanted |
| `PickleTools/TESTING.md` | `650adce` 2026-09-25, only "What to keep after a test, and what to delete" | The keep and delete table behind this mod's evidence rules | Only that section |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | `3c03f51` 2026-09-26 | The CI publication path | Not useful yet. Reread at `prepublished`, before any workflow, tag or secret |
| `Rimworld-Ticket-Dispatcher/docs/WELCOME.md` | `77ca9d7` 2026-09-27 | Which test to file, the request form, no watcher, a request carries no SHA | Yes |
| `Rimworld-Ticket-Dispatcher/docs/SUBMIT.md` | `d07b2b8` 2026-09-26 | Every option of `Submit-PickleRun.ps1`, the exit codes of `RUN_DONE` | Yes |

## This mod's own files

| File | State on 2026-09-28 |
| --- | --- |
| `STATUS.md`, `README.md`, `CHANGELOG.md`, `ATTRIBUTION.md`, `LICENSE`, `Mod/About/About.xml` | Read. `README.md` only in its first 40 lines |
| `TEST_SCENARIOS.md`, `Tests/README.md`, the old `Tests/Results/README.md` | Read, then updated or folded into `TESTING.md` |
| `TESTING.md`, `BACKLOG.md`, `docs/runs/`, `Tests/Pickle/` | Created on 2026-09-28 |
| `PUBLICATION.md`, `NOTES.md`, `BUGS.md` | Do not exist. `PUBLICATION.md` is owed at `prepublished`; the other two have no content to hold |

## Not a document but a lesson

A recursive `grep -r` over the collection root, started to look for one word, ran past the tool's time limit and had to be stopped. Search a
named folder, or use `scripts/Search-Workshop.sh`.
