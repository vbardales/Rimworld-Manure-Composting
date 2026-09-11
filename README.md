# Manure Composting

A RimWorld 1.6 companion mod joining **Burok's Manure** to **Dubs Bad Hygiene**.

Manure simulates animals producing manure, drying it by weather and temperature, giving fresh
manure a smell, and turning dried manure into fuel and chemfuel. It does not touch Dubs Bad
Hygiene at all. This mod adds the building that connects them, and wires manure into Fertile
Fields' compost chain.

- Public. Nothing is redistributed — see [ATTRIBUTION.md](ATTRIBUTION.md).
- packageId `nelim.manurecomposting`.

## What it adds

**A manure composter.** Built from the Hygiene tab, sharing an Architect dropdown with DBH's own
biosolids composter. Takes fresh `Manure`, produces `Biosolids` — the fertiliser DBH makes from
sewage, and the input Fertile Fields pasteurises into proper fertiliser.

There is a real decision in it: fresh manure dries into fuel by itself in about a day, faster in
heat. Composting it means getting it hauled before it dries. Fuel or soil, not both.

**Fertile Fields compost.** `MakeCompost` and `MakeCompost5` accept manure, fresh or dried.

## How it is built

The composter is not a new building class. Its `thingClass` is `DubsBadHygiene.Building_Composter`
and it is configured through DBH's own `CompProperties_Composter`:

```xml
<li Class="DubsBadHygiene.CompProperties_Composter">
  <Material>Manure</Material>
  <Product>Biosolids</Product>
</li>
```

DBH's composter reads its input and output through `ThingDefToCompost_PatchMe()` and
`ThingDefToProduce_PatchMe()` — `public virtual`, and named by Dubs to invite this. Progress, the
temperature speed factor, the fill bar, the inspect string and the save format are all DBH's code
running on our def, so the two composters behave identically and stay in step with DBH.

DBH's two WorkGivers are the one thing that is *not* generic:

```csharp
public override ThingRequest PotentialWorkThingRequest =>
    ThingRequest.ForDef(DubDef.BiosolidsComposter);
```

Both scan for that single def, so a pawn never sees a second composter however it is defined.
`Source/WorkGivers.cs` subclasses each and overrides that one property. Everything else —
finding the input, the temperature band, the fail reasons, the jobs — is inherited. The whole
assembly is about four kilobytes.

## Deliberate omissions

| Not done | Why |
|---|---|
| Manure in `Make_FertilizerFromBiosolids` | Would take manure to fertiliser without a composter, defeating the mod |
| Dried manure in refuelable fuel filters | Manure already ships that exact patch |
| A chemfuel recipe | Manure already has `Make_ChemfuelFromDryManure` |
| `Make_Ash2` / `Make_Ash12` | Gone from Fertile Fields 1.6 — present only in its 1–1.5 folders |
| Anything touching Poo Patch | It refines fecal sludge in VFE's automated factory; different building, different input |
| A VGP Garden Tools patch | Velcroboy's VGP dependency existed only for his own fertilizer recipes, which are not carried here |

## Patch guards

Every patch is conditional on **the def it modifies**, never on a mod's display name.
`PatchOperationFindMod` compares display names, and those drift: the installed Fertile Fields
calls itself *Fertile Fields 1.6*, so a patch written against *Fertile Fields 1.5* already misses.
Testing for the target def cannot drift and needs no maintenance across renames and continuations.

`Patches/BurnItForFuel.xml` currently matches nothing on purpose — [JPT] Burn It for Fuel stops at
1.3 and cannot load in 1.6. It is kept because the guard costs nothing and it will start working
by itself if a 1.6 continuation appears keeping the `BurnItForFuel` defName.

## Building

```bash
dotnet build Source/ManureComposting.csproj
```

Output goes to `Mod/Assemblies/`. The DBH reference uses a `HintPath` into the Workshop install
and is marked `<Private>false</Private>` so `BadHygiene.dll` is never copied beside ours — RimWorld
loads every assembly in `Assemblies/`, and a second copy would mean two incompatible sets of DBH
types in one process.

## Verified

```
scripts/Check-XmlFields.ps1   6 files, no unknown fields
scripts/Check-XmlClasses.ps1  7 types referenced, all resolved
scripts/Check-DefRefs.ps1     no unresolved def references, all ParentName resolved
```

Not yet tested in a running game.
