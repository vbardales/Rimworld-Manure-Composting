# Runs

What each test run of this mod showed, in text. **The evidence itself is on disk and ignored by git**
(`Tests/Pickle/Evidence/`, `Tests/Results/`). One line per run, never a folder. Which proofs to keep and which to drop after a
test is written in [TESTING.md](../../TESTING.md#evidence-what-to-keep-what-to-delete).

Rules for a line:

- Say the revision (short SHA and whether the working tree was clean), the game build, the pass and the language.
- Read `exitReason` before the counts; a report with no `summary.json` is NO REPORT, never a pass.
- Say what was not shown. A summary that lists only what passed misleads.

| File | Covers |
| --- | --- |
| [2026-09-28.md](2026-09-28.md) | Offline tests replayed on the delivered build; the Pickle suite written and its vocabulary checked |
