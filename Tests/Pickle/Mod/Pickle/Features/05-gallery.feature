# Feature: Manure Composting gallery (shotlist reworked 2026-10-26, nothing played, no scenario written yet)
#
# STORY. Nelim, the only colonist of the Sanctuary (NSB), protagonist. Two days at the animal pen, same work
# shirt both days (ochre `Apparel_BasicShirt` rgb (205, 150, 60) over her fixture trousers, canonical high
# ponytail `Roo_HD_Hair_Highpony`, no hat, her own face: smirk smile). Day 1: the new manure composter stands at
# the pen gate; Nelim milks, hauls the muck, fills it. Day 3: the finished composter is emptied and the
# biosolids go to the flower garden. Rhythm: one `I set the hour to N` per scene, the day change is written in
# the subtitle ("Two days on"), never played. The composter's home is one place on purpose (enclosure-south,
# the pen the animals live in); the zoom changes from shot to shot (wide, medium, close, medium-tight, wide).
# One scene = one Scenario = one image. Paused mid-play: each gesture is a forced job, with `game speed is paused` set in the setup, then
# `I advance the paused game by exactly N ticks` (the game stays paused). Every prop, heap and stand-in animal below is
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
#                            dropdown holding both composters. Step: `Nelim's Pickle Tools: I open the architect tab "Hygiene"` (NPT, 2026-10-26, unplayed).
# 3 workshop-3-hauling       enclosure-south, zoom 7 medium, day 1 09:00 Clear, bright side light. Instant: two steps
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
#                            ingredient list. Steps: add the bill with `the building "<def>" at (x, z) has the bill "<recipe>"`, then `I open the configuration of the bill "<RecipeDef>" on the building "<def>" at (x, z)` (NPT, 2026-10-26, unplayed).
# 7 workshop-7-garden        flower-garden (154,105) zoom 9 wide, day 3 18:00 golden hour, closing image. Instant:
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
@review @timeout:1800 @requires:nelim.pickletools.colonistrace @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.camerazoom @requires:nelim.pickletools.stagedecor @requires:Burok.Manure @requires:jamaicancastle.RF.fertilefields
@review @timeout:1800 @requires:nelim.pickletools.colonistrace @requires:nelim.pickletools.clickdiagnostics @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.camerazoom @requires:nelim.pickletools.stagedecor @requires:Burok.Manure @requires:jamaicancastle.RF.fertilefields
Feature: Manure Composting - gallery

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: all filth is cleaned
    And Nelim's Pickle Tools: all humans but "Nelim" are removed
    And I set the weather to "Clear"

  Scenario: gallery-1-pen-dawn
    Given I set the hour to 6
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Pickle Tools: the selection brackets are hidden
    And Nelim's Pickle Tools: I move the mouse to (10, 10)
    And the temperature at (146, 214) is above 0
    And a "Nelim_ManureComposter" is built at (146, 214)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (157, 208)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (157, 208) is lit
    And Nelim's Pickle Tools: I place the decor "Hay" at (150, 216)
    And Manure Composting: 12 manure lies at (143, 211)
    And Manure Composting: 12 manure lies at (145, 210)
    And Manure Composting: 12 manure lies at (151, 211)
    And Manure Composting: 12 manure lies at (153, 213)
    And Nelim's Pickle Tools: an adult animal of kind "Cow" named "Clover" is spawned at (149, 216)
    And Nelim's Pickle Tools: an adult animal of kind "Sheep" named "Dot" is spawned at (153, 218)
    And Nelim's Pickle Tools: an adult animal of kind "Sheep" named "Pip" is spawned at (155, 217)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (205, 150, 60)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (110, 76, 48)
    And Nelim's Pickle Tools: "Nelim" stands at (148, 215) facing East
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Heart"
    And Nelim's Pickle Tools: "Nelim" face kit is "smile"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmirk"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "Swift"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+moodCheerful2+blink"
    And Nelim's Pickle Tools: the animal "Clover" stands at (149, 216) facing South
    And Nelim's Pickle Tools: "Nelim" is forced into the job "Milk" on "Clover"
    And Nelim's Pickle Tools: I advance the paused game by exactly 60 ticks
    And Nelim's Pickle Tools: the camera is centered on "Nelim" at root size 9
    When Nelim's Pickle Tools: I let 5 frames pass
    Then I take a screenshot "gallery 1 pen dawn"
    And Nelim's Pickle Tools: the decor is removed

  Scenario: gallery-2-hygiene-tab
    Given I set the hour to 7
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And Nelim's Pickle Tools: I open the architect tab "Hygiene"
    And Nelim's Pickle Tools: I frame the cell (146, 214) at zoom 9
    When Nelim's Pickle Tools: I let 5 frames pass
    Then I take a screenshot "gallery 2 hygiene tab"
    And Nelim's Pickle Tools: the decor is removed

  Scenario: gallery-3-hauling
    Given I set the hour to 9
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Pickle Tools: the selection brackets are hidden
    And Nelim's Pickle Tools: I move the mouse to (10, 10)
    And the temperature at (146, 214) is above 0
    And a "Nelim_ManureComposter" is built at (146, 214)
    And Nelim's Pickle Tools: I place the decor "Stool" at (141, 216)
    And Nelim's Pickle Tools: I place the decor "Hay" at (150, 212)
    And Manure Composting: 30 manure lies at (138, 214)
    And Nelim's Pickle Tools: an adult animal of kind "Chicken" named "Pecky" is spawned at (143, 217)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (205, 150, 60)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (110, 76, 48)
    And Nelim's Pickle Tools: "Nelim" stands at (139, 214) facing East
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Heart"
    And Nelim's Pickle Tools: "Nelim" face kit is "smile"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmirk"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "Swift"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+moodCheerful2+blink"
    And Nelim's Pickle Tools: "Nelim" is forced to haul 30 of the item "Manure" to (145, 214)
    And Nelim's Pickle Tools: I advance the paused game by exactly 120 ticks
    And Nelim's Pickle Tools: the camera is centered on "Nelim" at root size 7
    When Nelim's Pickle Tools: I let 5 frames pass
    Then I take a screenshot "gallery 3 hauling"
    And Nelim's Pickle Tools: the decor is removed

  Scenario: gallery-4-contents
    Given I set the hour to 12
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Pickle Tools: the selection brackets are hidden
    And Nelim's Pickle Tools: I move the mouse to (10, 10)
    And the temperature at (146, 214) is above 0
    And a "Nelim_ManureComposter" is built at (146, 214)
    And Manure Composting: 30 manure lies at (144, 214)
    And Nelim's Pickle Tools: I place the decor "Hay" at (150, 212)
    And Nelim's Pickle Tools: I place the decor "Stool" at (141, 216)
    And Nelim's Pickle Tools: an adult animal of kind "Chicken" named "Pecky" is spawned at (148, 217)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (205, 150, 60)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (110, 76, 48)
    And Nelim's Pickle Tools: "Nelim" stands at (144, 215) facing North
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Heart"
    And Nelim's Pickle Tools: "Nelim" face kit is "smile"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmirk"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "Swift"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+moodCheerful2+blink"
    And Nelim's Pickle Tools: "Nelim" is forced into the job "LoadComposter" on the building "Nelim_ManureComposter" at (146, 214)
    And Nelim's Pickle Tools: I advance the paused game by exactly 60 ticks
    And Manure Composting: I select the composter at (146, 214) and look at it
    And Nelim's Pickle Tools: I frame the cell (146, 214) at zoom 4
    When Nelim's Pickle Tools: I let 5 frames pass
    Then I take a screenshot "gallery 4 contents"
    And Nelim's Pickle Tools: the decor is removed

  Scenario: gallery-5-biosolids
    Given I set the hour to 16
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Pickle Tools: the selection brackets are hidden
    And Nelim's Pickle Tools: I move the mouse to (10, 10)
    And the temperature at (146, 214) is above 0
    And a "Nelim_ManureComposter" is built at (146, 214)
    And Manure Composting: 30 manure lies at (144, 214)
    And Manure Composting: the development control finishes the composter at (146, 214)
    And Nelim's Pickle Tools: I place the decor "PlantPot" at (141, 212)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (141, 212) fully grown
    And Nelim's Pickle Tools: I place the decor "Biosolids" at (148, 212)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (205, 150, 60)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (110, 76, 48)
    And Nelim's Pickle Tools: "Nelim" stands at (145, 215) facing East
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Heart"
    And Nelim's Pickle Tools: "Nelim" face kit is "smile"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmirk"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "Swift"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+moodCheerful2+blink"
    And Nelim's Pickle Tools: the animal "Yuki" stands at (151, 212) facing South
    And Nelim's Pickle Tools: "Yuki" is forced to walk to (151, 216)
    And Nelim's Pickle Tools: "Nelim" is forced into the job "UnloadComposter" on the building "Nelim_ManureComposter" at (146, 214)
    And Nelim's Pickle Tools: I advance the paused game by exactly 40 ticks
    And Nelim's Pickle Tools: the camera is centered on "Nelim" at root size 6
    When Nelim's Pickle Tools: I let 5 frames pass
    Then I take a screenshot "gallery 5 biosolids"
    And Nelim's Pickle Tools: the decor is removed

  Scenario: gallery-6-fertile-fields-bill
    Given I set the hour to 12
    And Nelim's Sanctuary: I am at the sanctuary "window-backdrop-for-height"
    And a "CraftingSpot" is built at (90, 140)
    And Nelim's Pickle Tools: the building "CraftingSpot" at (90, 140) has the bill "MakeCompost"
    And Nelim's Pickle Tools: I open the configuration of the bill "MakeCompost" on the building "CraftingSpot" at (90, 140)
    When Nelim's Pickle Tools: I let 5 frames pass
    Then I take a screenshot "gallery 6 fertile fields bill"
    And Nelim's Pickle Tools: the decor is removed

  Scenario: gallery-7-garden
    Given I set the hour to 18
    And Nelim's Sanctuary: I am at the sanctuary "flower-garden"
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Pickle Tools: the selection brackets are hidden
    And Nelim's Pickle Tools: I move the mouse to (10, 10)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (205, 150, 60)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (110, 76, 48)
    And Nelim's Pickle Tools: "Nelim" stands at (152, 105) facing East
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Heart"
    And Nelim's Pickle Tools: "Nelim" face kit is "smile"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmirk"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "Swift"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+moodCheerful2+blink"
    And Nelim's Pickle Tools: I place the decor "Biosolids" at (157, 104)
    And Nelim's Pickle Tools: the plants from (150, 103) to (156, 108) are fully grown
    And Nelim's Pickle Tools: the animal "Shogun" stands at (151, 105) facing South
    And Nelim's Pickle Tools: "Shogun" is forced to walk to (151, 109)
    And Nelim's Pickle Tools: "Nelim" is forced to haul 30 of the item "Biosolids" to (155, 105)
    And Nelim's Pickle Tools: I advance the paused game by exactly 40 ticks
    And Nelim's Pickle Tools: the camera is centered on "Nelim" at root size 9
    When Nelim's Pickle Tools: I let 5 frames pass
    Then I take a screenshot "gallery 7 garden"
    And Nelim's Pickle Tools: the decor is removed
