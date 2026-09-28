# Backlog

Open work for this mod only.

## Upstream
- **Burok's Manure has a source repository: `https://github.com/Burakyilmam/Manure`.** Found 2026-09-28, linked by the user, confirmed by its README
  (credits Burok, links Workshop item 3784198780). Source only (14 `.cs` files), no `About.xml`, no `LICENSE` file. **`PUBLISHING.md` makes a pull
  request systematic once an upstream repository exists** — but this mod names Burok's ThingDefs and reuses none of Burok's code, so it likely has
  nothing to propose there. Read the source to confirm before closing this line: only with the owner's word, since a fork and a PR are public.
- **No source repository is known for Velcroboy's Manure** (`3252954927`), the mod whose idea (not code) is credited. Checked on 2026-09-28: its local
  `About.xml` carries no `<url>`, a GitHub search returned nothing, and its Steam page description, read in a browser the same day, links no repository.
  No pull request is owed here; retry only if new evidence turns up.

## Tests

- Play the three passes of `TESTING.md` (minimal English, minimal French, with Fertile Fields). Nothing in the Pickle suite has run yet.

## Before `prepublished`

- Write `PUBLICATION.md`: the Steam description as a Markdown block, the screenshots in order with what each shows, the answer to the
  adult-content boxes, the dependency list, the change note for `1.0.0`, and the thank-you comments (Burok's Manure and Dubs Bad
  Hygiene are hard dependencies; Fertile Fields is the optional integration; Velcroboy's mod is the idea). Read `WORKSHOP_COMMENTS.md` first:
  its register has no row for Burok's Manure and a `drafted` row for Dubs Bad Hygiene owned by another mod.
- The description of the private item was set when it was created (`0.1.0`) and is not resent by an upload from the game: a correction goes
  by the CI's `update_description` or by hand on the page.
- Once the Pickle passes have run, add Pickle and RimLogging to `THANKS` in the description, as development-only tools and never a dependency
  of the mod (`PUBLISHING.md`, "Mentions"). They are not named there yet: the tools have not been used yet.

## Dependencies, read on Steam 2026-09-28 in a browser

- **Burn It for Fuel has two 1.6 successors, and the patch may aim at neither.** The installed `JPT.BurnItForFuel` (`1823276856`, obsolete, 1.1 to 1.3, needs HugsLib)
  is the target of `Mod/Patches/BurnItForFuel.xml` and of a `loadAfter`. Mlie's "[Depricated] (Continued)" (`3004932466`, declares 1.6, needs Harmony and HugsLib) and jptrrs's
  "Burn It for Fuel 2" (`3553442151`, 1.6, no dependency, a rewrite with a per-building fuel tab) are not installed here. Subscribe to both, read their defs, and decide
  whether the patch targets a def that exists, whether `loadAfter` needs their packageIds, and whether the description and `ATTRIBUTION.md` (which say "no continuation is
  installed") need the two named. Then add the live scenario. Any change touches `Mod/`, so it waits until the three queued tickets have finished. Source: GitHub
  `jptrrs/BurnItForFuel`.
- **Dubs Bad Hygiene** (`836308268`, Dubwise): alive, 1.6, updated 2025-07-21, and its descriptions give an issue tracker and releases at
  `github.com/Dubwise56/Dubs-Bad-Hygiene`. It is a hard dependency, not the origin of this mod, so no pull request rule applies. Its extension points named
  `ThingDefToCompost_PatchMe` and `ThingDefToProduce_PatchMe` are what this mod relies on; a change there is a reason to rerun the passes.
- **Fertile Fields 1.6** (`3225843229`, Greysuki, the current maintainer): its description credits three people, Rainbeau Flambe (original), Jamaican Castle
  (maintainer until 1.4) and Greysuki, and its licence asks only to be told about a derivative or basis. This mod is neither, but the thank-you comment at
  `prepublished` credits all three, in one message on this page. The installed packageId is `jamaicancastle.RF.fertilefields`, unchanged by the continuation.
  Its known issues list Odyssey terrain as unsupported, which this mod does not touch.
