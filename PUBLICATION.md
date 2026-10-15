# Manure Composting - publication

Started 2026-10-15. Only the gallery sections exist so far. Still to write before `prepareRelease` (see `BACKLOG.md`): the Steam description as a Markdown block, the answer to the adult-content boxes, the dependency list, the change note for `1.0.0` and the thank-you comments.

## Gallery plan

**Status: none of these captures exists yet.** `Art/Gallery/` holds only `0-preview.png`. The only captures taken so far are the two `@review` captures of feature `03-review-inspect-text`: they test that the inspect pane reads correctly in each language, on a bare test map, with the default pawns. They tell no story and are not gallery images. The gallery is a separate series, written for `GALLERY.md`, played in Nelim's Sanctuary (`SanctuaryBacklot`) with its own pass map, one Pickle `Scenario:` per image.

**The story: one working day at the barn, from muck to garden.** Nelim, the only colonist of the Sanctuary and the protagonist, starts the day among the animals, learns what the new building does, carries the manure to it, comes back when the box is full, and ends the day in the garden that the compost feeds. Place: the barn and its enclosure for the first half, the flower garden for the last scene. The hour moves from dawn to evening.

| # | Scene (place, hour) | Subject and cast | Subtitle |
|---|---|---|---|
| 1 | Barn, dawn | Nelim leaning on the barn gate, fresh manure on the ground. Shogun (labrador) and Yuki (husky) in front of her, facing the camera | yes |
| 2 | Architect, Hygiene tab | The dropdown that groups the manure composter and DBH's biosolids composter. Interface capture, cropped | no |
| 3 | Barn enclosure, morning | Nelim hauling a heap of manure to the composter, a thrumbo watching from behind the fence | yes |
| 4 | Barn enclosure, noon | The composter selected, its inspect tab open ("Contains manure", progress, temperature). Interface capture on the story's place | no |
| 5 | Barn enclosure, evening | Nelim emptying the finished composter, a heap of biosolids beside it | yes |
| 6 | Workbench, bill window | The Fertile Fields compost bill, manure in its ingredient list. Interface capture, cropped | no |
| 7 | Flower garden, golden hour | Nelim among the plants grown on that fertiliser, Shogun sitting beside her | yes |

**What each scene still has to settle, because none of it is done:**
- **Nelim's look.** The fixture gives her dark brown eyes, trousers and her own face (two brows, smirk, `blink`). For this series: a farm outfit that makes the barn read (vanilla apparel such as `Apparel_BasicShirt` dyed in a warm tone, a work hat for the barn scenes, no hat in the garden), a hairstyle that holds up under a hat, and an expression per scene chosen among Facial Animation's list (only `blink` is verified so far). The def names are not checked against the game files yet.
- **Other pawns.** None planned: Nelim is alone with the animals. A guest is optional and not needed by the story.
- **Animals.** Shogun and Yuki are the fixture dogs, thrumbos the fixture herd (`SANCTUAIRE-LIEUX.md`, "Les animaux de la fixture"; the names come from Virginie and have not been checked in the save). At least one scene shows the animals facing the camera (`GALLERY.md`).
- **Mods to load.** Beyond the two dependencies and Fertile Fields: the Sanctuary's own tools (`screenshotstudio`, `camerazoom`, `stagedecor`, `inspecttabs`, `screenshotmode`), `lucius.eyegenes3` for Nelim's eyes, and any apparel or hair mod chosen to make her outfit stand out. Every mod goes in the `-DepMap` of the series.
- **Scene 5 needs a finished composter.** The `development control` ("Debug: Finish composting") already used by feature `01` finishes it.
- **Scene 7 needs grown plants.** `the plants from (x1, z1) to (x2, z2) are fully grown` (StageDecor).

## Gallery subtitles

One line of English at the bottom of each scene without an interface window, laid over the image like a film subtitle (`GALLERY.md`, "Sous-titres"). The story is Nelim's day at the barn, in the order above. `0-preview.png` (the Preview) has no subtitle, and neither have the interface captures (scenes 2, 4 and 6 of the plan). The files are the planned names: the clean original goes in `Art/Gallery-clean/`, the subtitled image in `Art/Gallery/`, both under 2 MB. A line changes here first, then the tool is replayed on the clean original. **None of them is laid yet: the captures do not exist.** The indexes below are the final gallery indexes: the interface captures take 2, 4 and 6.

| Index | File | Line |
|---|---|---|
| 1 | `1-barn-dawn.png` | Dawn at the barn: the animals have already left their mark. |
| 3 | `3-hauling.png` | Nelim hauls the muck before the sun can dry it. |
| 5 | `5-biosolids.png` | A few days on, the box gives back dark, rich fertiliser. |
| 7 | `7-garden.png` | From muck to garden: the first flowers grow on the barn's own fertiliser. |
