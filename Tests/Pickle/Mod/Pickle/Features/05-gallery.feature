# Feature: Manure Composting gallery (shotlist written 2026-10-26, nothing played, no scenario written yet)
#
# STORY. Nelim, the only colonist of the Sanctuary (NSB), protagonist. Two days at the barn, same work
# shirt both days (ochre `Apparel_BasicShirt` rgb (205, 150, 60) over her fixture trousers, canonical high
# ponytail `Roo_HD_Hair_Highpony`, no hat, her own face: smirk smile). Day 1: the new manure composter stands
# in the barn corner; Nelim milks, hauls the muck out, fills it. Day 3: the finished composter is emptied and
# the biosolids go to the flower garden. Rhythm: one `I set the hour to N` per scene, the day change is
# written in the subtitle ("Two days on"), never played.
# One scene = one Scenario = one image. Paused mid-play: each gesture is a forced job followed by
# `I let N ticks pass` then `time is paused for the capture`.
#
# 1 workshop-1-barn-dawn      barn (196,237) zoom 8.5, day 1 06:00 Clear, wide/medium. Instant: just after Clover
#                             left her mark, before Nelim picks up the shovel. Nelim forced into job "Milk" on
#                             cow "Clover" (60 ticks, then pause). Clover eats hay, turned south; two sheep behind,
#                             four stacks of fresh manure on the floor, `Hay` stack, `TorchLamp` lit, the
#                             "Nelim_ManureComposter" built in the corner, empty. Says: the barn leaves a mark,
#                             the answer stands in the corner. Subtitle "Dawn at the barn: the animals have already left their mark."
# 2 workshop-2-hygiene-tab    interface, barn 07:00, Hygiene architect tab open on the dropdown, no subtitle.
#                             Needs a step to open the architect tab (asked to NPT).
# 3 workshop-3-hauling        enclosure-south (149,214) zoom 12, day 1 09:30 Clear, medium. Instant: two steps from
#                             the bin, about to tip. Composter built at (146,214); Nelim forced to haul 30 of the
#                             Burok manure def to (145,214), 120 ticks then pause; 30 manure on the ground behind her,
#                             hen "Pecky" pecking near the nesting boxes, fence and a crate as props. Says: she
#                             carries it before the sun dries it. Subtitle "Nelim hauls the muck before the sun can dry it."
# 4 workshop-4-contents       inspect tab on the story place, enclosure-south, day 1 12:00, zoom 8 (frame shifted
#                             N*0.46 cells left for the panel), no subtitle. Instant: she has just dropped the last load.
#                             Nelim forced into job "LoadComposter" on the composter, pause, composter selected, inspect
#                             text "Contains manure: 30/250" open. The gauge must read from the sprite, not the text.
# 5 workshop-5-biosolids      enclosure-south, day 3 16:00 Clear, medium/tight. Composter finished by the development
#                             control. Instant: first toil of the unload. Nelim forced into job "UnloadComposter",
#                             paused; a heap of `Biosolids` beside; Yuki (husky) walking toward the heap, facing the
#                             camera. Subtitle "Two days on, the box gives back dark, rich fertiliser."
# 6 workshop-6-fertile-fields-bill   interface window on window-backdrop-for-height, cropped, no subtitle: the
#                             Fertile Fields "make raw compost" bill with Manure and DryManure in the ingredient list.
#                             Needs a step to open the bill configuration dialog (asked to NPT).
# 7 workshop-7-garden         flower-garden (154,105) zoom 9, day 3 18:30 golden hour, wide, closing image. Instant:
#                             Nelim sets the last Biosolids down at the bed. Forced to haul 30 `Biosolids` to the
#                             bed cell; `Plant_Daylily` and roses fully grown (`Plant_Rose` to verify); a heap of
#                             Biosolids in the background; Shogun (labrador) follows her, facing the camera.
#                             Subtitle "From muck to garden: the first flowers grow on the barn's own fertiliser."
#
# DepMap: the Sanctuary map as base, plus Burok.Manure 3784198780, Dubwise.DubsBadHygiene 836308268,
# jamaicancastle.RF.fertilefields 3225843229, nelim.manurecomposting.pickletests.
# Colonists: Nelim only (NSB). No other colonist without the owner's express, reasoned approval.
# Animals: Clover (cow), two sheep, hen, Shogun, Yuki: fixture animals first, spawn named stand-ins only if
# the fixture ones cannot be placed. Dressing: none (the dogs keep their leather collar).
Feature: Manure Composting - gallery
