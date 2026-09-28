# Manure Composting Pickle suite

A companion mod, `nelim.manurecomposting.pickletests`, development only and never shipped in `Mod/`. It holds four features and one step assembly. It covers
only what a running game can show: a pawn finding the second composter, the architect dropdown, the inspect text in the language of the game, a
reload, and Fertile Fields' recipes patched in a real load. Everything a test outside the game can prove stays in `../` (see
[../../TESTING.md](../../TESTING.md) for the split and for what is deliberately left out).

| Feature | Passes |
| --- | --- |
| `01-architect-and-work` | minimal-en, minimal-fr |
| `02-save-and-reload` | minimal-en, minimal-fr |
| `03-review-inspect-text` (`@review`) | minimal-en, minimal-fr |
| `04-fertile-fields` (`@requires:jamaicancastle.RF.fertilefields`) | avec-fertilefields |

The step assembly is committed under `Mod/Pickle/Assemblies/` because the staging copies the folder as it is. Rebuild it after any change of
`Source/`, then check the vocabulary before filing a ticket:

```powershell
dotnet build Tests/Pickle/Source/ManureComposting.PickleSteps.csproj -c Release
powershell.exe -ExecutionPolicy Bypass -File Tests/Pickle/Check-Steps.ps1
```

Play nothing from a session directly: file a request with `Rimworld-Ticket-Dispatcher\scripts\Submit-PickleRun.ps1` (commands in
`TESTING.md`). A request carries no SHA, the mod being staged from the working tree when its ticket is played, so keep `Mod/`, `Source/` and
`Tests/Pickle/` still until the `RUN_DONE` of every ticket in flight.

`wsl-ids.map` resolves the Workshop ids of the two hard dependencies (Burok's Manure, Dubs Bad Hygiene) in every pass. `wsl-deps.avec-fertilefields.map`
adds Fertile Fields for the one pass that needs it. Every map ends with a newline: the staging silently drops an unterminated last line.

The scenarios use cells of the `test-colony` fixture around (144, 158) and (146, 158), and read the temperature there first. If a first exploratory ticket
shows the fixture differs (a blocked cell, a cold map), change the cells or the precondition, not the assertions.

Reports are copied to `Tests/Pickle/Evidence/<date>-<pass>/` by the launcher's `-EvidenceDir`; that folder is ignored by git. What to keep from it and what to
delete is written in `TESTING.md`.
