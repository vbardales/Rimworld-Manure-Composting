# Changelog

## 1.0.1 — unreleased, 2026-09-13

- Install 128x128 icon and 896x504 preview; preserve originals and reproducible composition in Art/.
- Add French coverage and translated development control, with correct manure contents and DBH loading/unloading reports.
- Correct the cold-temperature description: DBH slows composting; extreme temperatures can ruin contents.
- Preserve DBH behavior and saved state through a text-only building subclass.
- Add the final source-code link and remove unverified live-testing claims.
- Keep build intermediates within the standalone repository.
- Add executable patch/WorkGiver, text-adapter and resource tests, plus written in-game scenarios.
- Final validation in a running game remains pending.

## 1.0.0 — unreleased

First version. Not yet tested in a running game.

### Added

- **Manure composter** (`Nelim_ManureComposter`). Turns Burok's `Manure` into Dubs Bad Hygiene's
  `Biosolids`. Built from the Hygiene tab, sharing a `DesignatorDropdownGroupDef` with DBH's own
  biosolids composter, which is added to that group by patch.
- Two WorkGivers, `Nelim_FillManureComposter` and `Nelim_UnloadManureComposter`, at the same
  priorities as DBH's own (19 and 20) so neither composter always wins.
- **Fertile Fields**: `MakeCompost` and `MakeCompost5` accept `Manure` and `DryManure`. Dried
  manure is ticked in `defaultIngredientFilter`; fresh is not, so a standing bill does not quietly
  compete with the composter for the same input.
- **[JPT] Burn It for Fuel**: `DryManure` added to the burner's storage filter. Inert today — that
  mod stops at 1.3 — but guarded on the def, so it starts working if a 1.6 continuation keeps the
  `BurnItForFuel` defName.

### Notes on the shape

Written as a companion to Burok's Manure (`Burok.Manure`, 1.6, alive) rather than as a port of
Velcroboy's Manure (`Manure.Public.Velcroboy333`, dead at 1.5). Burok's mod already covers the
simulation — a `Need_Digestion` on animals, the drying curve, rot-stink gas, dried-manure fuel,
chemfuel, and three tiers of manure soil — so a port would have shipped duplicate manure items
and a duplicate chemfuel recipe beside a living mod. What it does not cover is any contact with
Dubs Bad Hygiene, and that is what this adds.

Nothing is redistributed. The composter is DBH's `Building_Composter` configured through DBH's own
comp, and the assembly is two property overrides written against DBH's public API.

### Checked, and deliberately not carried over

- The refuelable fuel-filter patch: Burok's Manure already ships the identical `WoodLog`-anchored
  patch.
- A chemfuel recipe: Burok's Manure already has one. Poo Patch does not conflict — it refines DBH
  fecal sludge in VFE's automated factory, a different building with a different input.
- `Make_Ash2` / `Make_Ash12`: removed from Fertile Fields 1.6.
- A VGP Garden Tools patch: only ever needed for Velcroboy's own fertilizer recipes.

### Defects found in Velcroboy's Manure while reading it, not reproduced here

- `CompDecompToFertile.UpgradeTerrain` and `BurriedDung` write `fertility` on the shared
  `TerrainDef` rather than the tile, changing every tile of that soil type on every map,
  permanently for the session and outside the save.
- `CompDungSpawner.CompTickRare()` passes an interval of 1000 while a rare tick is 250, so manure
  arrives four times faster than configured.
- `spawnIntervalRangeLow` / `High` are `static`, initialised at type load, so the frequency
  sliders do nothing mid-game.
