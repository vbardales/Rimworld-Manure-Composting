# Feature: Manure Composting gallery (shotlist reworked 2026-10-26, nothing played, no scenario written yet)
#
# STORY. Nelim, the only colonist of the Sanctuary (NSB), protagonist. Two days at the animal pen, same work
# shirt both days (ochre `Apparel_BasicShirt` rgb (205, 150, 60) over her fixture trousers, canonical high
# ponytail `Roo_HD_Hair_Highpony`, no hat, her own face: smirk smile). Day 1: the new manure composter stands at
# the pen gate; Nelim milks, hauls the muck, fills it. Day 3: the finished composter is emptied and the
# biosolids go to the flower garden. Rhythm: one `I set the hour to N` per scene, the day change is written in
# the subtitle ("Two days on"), never played. The composter's home is one place on purpose (enclosure-south,
# the pen the animals live in); the zoom changes from shot to shot (wide, medium, close, medium-tight, wide).
# One scene = one Scenario = one image. Paused mid-play: each gesture is a forced job followed by
# `I let N ticks pass` then `time is paused for the capture`. Every prop, heap and stand-in animal below is
# removed after its shot (`the decor is removed`), and each Scenario reloads the save.
#
# 1 workshop-1-pen-dawn      enclosure-south (149,214) zoom 9 wide, day 1 06:00 Clear, dawn light. Foreground: cow
#                            "Clover" eating `Hay`, turned south; Nelim forced into job "Milk" on Clover (60 ticks,
#                            then pause), instant: just after Clover left her mark, before Nelim picks up the
#                            shovel. Left of Nelim the "Nelim_ManureComposter" built at (146,214), empty; behind:
#                            two sheep, four stacks of fresh manure, the fence, `TorchLamp` lit at the gate,
#                            nesting boxes. Subject off-centre right. Says: the pen leaves a mark, the answer stands
#                            at the gate. Subtitle "Dawn at the pen: the animals have already left their mark."
# 2 workshop-2-hygiene-tab   interface capture (no subtitle, not rated): Hygiene architect tab open on the
#                            dropdown holding both composters. Needs a step to open the architect tab (asked to NPT).
# 3 workshop-3-hauling       enclosure-south, zoom 7 medium, day 1 09:30 Clear, bright side light. Instant: two steps
#                            from the bin, about to tip. Nelim forced to haul 30 of the Burok manure def to (145,214),
#                            120 ticks, pause; the composter fills the right third; hen "Pecky" in the foreground
#                            left, `Stool` and a `Hay` bale as props, 30 manure on the ground behind her (all removed
#                            after the shot). Says: she carries it before the sun dries it.
#                            Subtitle "Nelim hauls the muck before the sun can dry it."
# 4 workshop-4-contents      close shot, enclosure-south, zoom 4, day 1 12:00 Clear, noon light. The composter fills
#                            the left half of the frame (readable at 268 px), Nelim at its edge, inspect tab
#                            open on the right ("Contains manure: 30/250", not needed at thumbnail size). Instant:
#                            she has just dropped the last load, forced into job "LoadComposter", pause. Hen
#                            "Pecky" pecking in the lower right corner, `Hay` bale and `Stool` (removed after the
#                            shot). Says: a full box of muck. No subtitle (inspect tab, interface).
# 5 workshop-5-biosolids     enclosure-south, zoom 6 medium-tight, day 3 16:00 Clear, afternoon light. Composter
#                            finished by the development control. Instant: first toil of the unload, Nelim forced
#                            into job "UnloadComposter", pause. Beside her a heap of `Biosolids`; Yuki (husky) walking
#                            toward the heap, facing the camera, lower left; a `PlantPot` with `Plant_Daylily` fully
#                            grown at the gate hints at the garden (removed after the shot).
#                            Subtitle "Two days on, the box gives back dark, rich fertiliser."
# 6 workshop-6-fertile-fields-bill   interface window (no subtitle, not rated): window-backdrop-for-height,
#                            cropped, the Fertile Fields "make raw compost" bill with Manure and DryManure in the
#                            ingredient list. Needs a step to open the bill dialog (asked to NPT).
# 7 workshop-7-garden        flower-garden (154,105) zoom 9 wide, day 3 18:30 golden hour, closing image. Instant:
#                            Nelim sets the last sack of Biosolids down at the bed, forced to haul 30 `Biosolids`
#                            to the bed cell. Foreground right: the Biosolids heap, a third of the frame; the bed with
#                            `Plant_Daylily` and roses fully grown (`Plant_Rose` to verify), all removed after the
#                            shot. Shogun (labrador) follows her, walking toward the camera, left. Says: from muck
#                            to garden. Subtitle "From muck to garden: the first flowers grow on the pen's own
#                            fertiliser."
#
# DepMap: the Sanctuary map as base, plus Burok.Manure 3784198780, Dubwise.DubsBadHygiene 836308268,
# jamaicancastle.RF.fertilefields 3225843229, nelim.manurecomposting.pickletests.
# Colonists: Nelim only (NSB). No other colonist without the owner's express, reasoned approval.
# Animals: Clover (cow), two sheep, hen, Shogun, Yuki: fixture animals first, spawn named stand-ins only if
# the fixture ones cannot be placed. Dressing: none (the dogs keep their leather collar).
Feature: Manure Composting - gallery
