@requires:JPT.BurnItForFuel
Feature: Manure Composting - Burn It for Fuel's burner accepts dry manure in a real load

  Scenario: the burner stockpile is patched by this mod
    # BurnItForFuel is the def of "[JPT] Burn It for Fuel 2" (Workshop 3553442151, packageId
    # JPT.BurnItForFuel, 1.6). The step takes the mod display name as the game reports it
    # (see 04-fertile-fields.feature).
    Then def "BurnItForFuel" was patched by mod "Manure Composting"
    And no errors were logged
