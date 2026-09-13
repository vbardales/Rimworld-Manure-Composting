# Manure Composting

A RimWorld 1.6 companion joining **Burok's Manure** to **Dubs Bad Hygiene**,
with optional **Fertile Fields** integration. Public; packageId nelim.manurecomposting.
MIT covers this mod's own work; dependencies are loaded from the player's own installation,
not redistributed. See [ATTRIBUTION.md](ATTRIBUTION.md).

## Features

- A manure composter in the Hygiene tab, sharing a dropdown with DBH's biosolids composter.
  It converts fresh manure into biosolids using DBH's composting, temperature and save logic.
- Fresh manure may dry into fuel before it is hauled: choose fuel or composting.
- With Fertile Fields, MakeCompost and MakeCompost5 accept fresh or dried manure.
  Only dried manure is selected by default, preserving fresh manure for the composter.
- English and French text, including corrected manure contents and compost-unloading reports.

## Implementation and compatibility

Two WorkGivers specialize DBH's scan target. Building_ManureComposter inherits DBH's
building and only adapts inspect/development-control text; it adds no saved fields or
replacement composting process. Cold slows composting, while extreme temperatures can
ruin the contents. DBH owns progression, capacity and temperature behavior.

Load after Manure and DBH, and after Fertile Fields when used. Manure declares its own
Harmony dependency. RIMMSQOL and other customization tools are not required: this mod
has no independent settings, empty settings page or main-button shortcut.

Patches guard their target XPath. The optional Burn It for Fuel patch is tested with a
synthetic compatible target; no live 1.6 continuation is claimed as tested. The mod does
not duplicate Manure's fuel or chemfuel recipes and does not bypass the composter by adding
manure to Fertile Fields' biosolids-to-fertilizer recipe.

Designed for existing saves, but final live validation is pending. Deconstruct all manure
composters before removing the mod. Test upgrades on a copy of your save.

## Build and checks

Run dotnet build Source/ManureComposting.csproj. Output goes to Mod/Assemblies and
intermediates stay in this repository's .build directory. The DBH HintPath in the project
must point to your local 1.6 BadHygiene.dll; Private=false prevents copying it into this mod.

See [Tests/README.md](Tests/README.md), [test results](Tests/Results/README.md) and
[functional scenarios](TEST_SCENARIOS.md). Automated checks and build pass; **not yet
validated in a running game**.

## Artwork and credits

Preview illustration generated using OpenAI's built-in image generation. Art/Preview.png
preserves the source; Art/render.cjs composes the final preview using Art/preview-palette.json
and Segoe UI. Run with Node.js, Playwright, Sharp and Chrome installed. The original icon
is preserved in Art/ModIcon-original.png. Development used Claude Code and Codex under
human direction.

Thanks to Burok, Dubwise and Velcroboy; full credit and the removal commitment are in
ATTRIBUTION.md. If I do not answer within a reasonable time after being contacted, anyone
may freely update this or any other of my mods, including publishing a continuation.
All credit must be preserved.

[Source code on GitHub](https://github.com/vbardales/Rimworld-Manure-Composting)
