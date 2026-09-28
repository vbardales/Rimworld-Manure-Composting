# Backlog

Open work for this mod only.

## Upstream

- **No source repository is known for the mods this one builds on.** Checked on 2026-09-28: the local `About.xml` of Burok's Manure
  (`3784198780`) and of Velcroboy's Manure (`3252954927`, the idea, no code used) carry no `<url>`, Velcroboy's `Credit.txt` names none,
  and a GitHub search returned nothing. The Steam pages themselves could not be read (HTTP 429), so a link in their descriptions is
  **not ruled out**. Retry both pages. If a repository appears, the rule of `PUBLISHING.md` applies: a pull request to it is
  systematic, and goes here until it is made. It stays public work, so it needs the owner's word first.

## Tests

- Play the three passes of `TESTING.md` (minimal English, minimal French, with Fertile Fields). Nothing in the Pickle suite has run yet.
- When a 1.6 continuation of `JPT.BurnItForFuel` exists, add a live scenario for the storage-filter patch. Until then it is justified as not
  applicable in `TESTING.md`.

## Before `prepublished`

- Write `PUBLICATION.md`: the Steam description as a Markdown block, the screenshots in order with what each shows, the answer to the
  adult-content boxes, the dependency list, the change note for `1.0.0`, and the thank-you comments (Burok's Manure and Dubs Bad
  Hygiene are hard dependencies; Fertile Fields is the optional integration; Velcroboy's mod is the idea). Read `WORKSHOP_COMMENTS.md` first:
  its register has no row for Burok's Manure and a `drafted` row for Dubs Bad Hygiene owned by another mod.
- The description of the private item was set when it was created (`0.1.0`) and is not resent by an upload from the game: a correction goes
  by the CI's `update_description` or by hand on the page.
- Once the Pickle passes have run, add Pickle and RimLogging to `THANKS` in the description, as development-only tools and never a dependency
  of the mod (`PUBLISHING.md`, "Mentions"). They are not named there yet: the tools have not been used yet.
