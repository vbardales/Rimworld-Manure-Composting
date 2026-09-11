# Attribution

## Summary

**Nothing in this mod is redistributed from another mod.** No code, no defs, no textures, no
sounds. That is unusual for this repository, and it is worth stating plainly up front, because it
is what makes the MIT licence in `LICENSE` cover the whole of the shipped content without a
carve-out.

The mod is a bridge between two living mods it depends on. It configures Dubs Bad Hygiene's
existing composter through DBH's own public XML surface, and it names Burok's manure items. Both
are hard dependencies, present at runtime; neither is copied.

## Dependencies (required, not redistributed)

### Manure — Burok

- Workshop `3784198780`, packageId `Burok.Manure`, 1.6, actively maintained
  (posted 2026-08-15, updated 2026-08-23).
- Supplies the `Manure` and `DryManure` ThingDefs this mod names, and the whole simulation
  behind them: a `Need_Digestion` on animals scaled by body size and food level, the
  weather-and-temperature drying curve, rot-stink gas from fresh manure, dried manure as
  refuelable fuel, chemfuel at the biofuel refinery, and three tiers of manure soil behind a
  `ManureFertilization` research.
- This mod adds nothing to that simulation and overrides none of it.

### Dubs Bad Hygiene — Dubwise

- Workshop `836308268`, packageId `Dubwise.DubsBadHygiene`, 1.0–1.6, actively maintained.
- Supplies `DubsBadHygiene.Building_Composter`, `DubsBadHygiene.CompProperties_Composter`, the
  `LoadComposter` / `UnloadComposter` jobs, the `Biosolids` item, the `Hygiene` designation
  category and the `BuildingsHygiene` thing category.
- The composter ThingDef here sets `thingClass` to DBH's class and configures it. The building's
  behaviour — progress, temperature factor, fill bar, inspect string, save format — is DBH's code
  running on a def of ours. Nothing is copied into this mod.
- `graphicData/texPath` points at `DBH/Things/Building/Sewage/Composter`, which is DBH's own
  texture resolved at load time from DBH's folder. No image file ships here.

DBH marks its own extension points: `Building_Composter` exposes the input and output through
`ThingDefToCompost_PatchMe()` and `ThingDefToProduce_PatchMe()`, both `public virtual` and named
by Dubs to invite exactly this.

## Written here

- `Source/WorkGivers.cs` — two classes, each overriding a single property. Written against DBH's
  public API, not copied from it.
- `Source/ManureCompostingDefs.cs` — a lazy def lookup.
- `Mod/Defs/ThingDefs_Buildings/ManureComposter.xml`, `Mod/Defs/WorkGiverDefs/WorkGivers.xml`.
- `Mod/Patches/*.xml` — written against the current 1.6 defs of each target.
- Packaging and documentation.

## Acknowledged, but not a source

### Manure — Velcroboy

- Workshop `3252954927`, packageId `Manure.Public.Velcroboy333`, 1.3 and 1.5, last updated
  2025-01-18. Dead at 1.5.
- **No code, def, texture or string from it is used here.** It was read closely while deciding
  what this mod should be, and it is credited for that: the idea of a manure composter, and the
  list of integrations worth having, came from reading it.
- It is credited rather than ported because Burok's Manure now covers the simulation Velcroboy's
  mod provided, and covers it with a real need-driven digestion model. Republishing it would put
  duplicate manure items and duplicate chemfuel recipes beside a living mod that already has both.
- Its `About/Credit.txt` states that most of its code was taken from Dubs Bad Hygiene. That does
  not reach this mod, since none of its code is here. The composter in this mod arrives at DBH by
  configuring DBH, which is the route Velcroboy's own XML shows he tried first — his
  `Composter.xml` still carries the commented-out `DubsBadHygiene.CompProperties_Composter` block.

Three defects were found in it while reading, and none are reproduced here:

- `CompDecompToFertile.UpgradeTerrain` writes `fertility` on the shared `TerrainDef` returned by
  `TerrainAt()` rather than on the tile, which raises fertility for every tile of that soil type
  on every map, permanently for the session and outside the save. `BurriedDung` does the same.
- `CompDungSpawner.CompTickRare()` calls `TickInterval(1000)` while a rare tick is 250, so manure
  arrives four times faster than the configured setting.
- `spawnIntervalRangeLow` / `High` are `static` fields initialised at type load, so the frequency
  sliders do nothing once the game is running.

### Optional integration targets

Named by def, never by mod display name, and each guarded so an absent target costs nothing:

- **Fertile Fields** — Workshop `3225843229`, packageId `jamaicancastle.RF.fertilefields`, 1.6.
  Its `MakeCompost` and `MakeCompost5` recipes are extended to accept manure.
- **[JPT] Burn It for Fuel** — Workshop `1823276856`, packageId `JPT.BurnItForFuel`. Declares
  `1.1, 1.2, 1.3` and **cannot load in 1.6**; no continuation is installed. The patch is kept
  because it is guarded on the def and will start working by itself if a 1.6 continuation appears
  keeping the `BurnItForFuel` defName. Until then it does nothing, by design.

## Removal

Nothing here is anyone else's to reclaim, since nothing is redistributed. If Burok or Dubwise
would nonetheless rather this mod did not exist against theirs, say so and it comes down.
