@requires:JPT.BurnItForFuel
Feature: Manure Composting - Burn It for Fuel's burner offers dry manure by default in a real load

  Scenario: dry manure is among the default fuels
    # "Burn It for Fuel 2" (Workshop 3553442151, packageId JPT.BurnItForFuel, 1.6) removes its def
    # BurnItForFuel at startup, so the patch cannot be read there. What can be read is the outcome: the
    # settings object, whose default filter is built from that def after the patch, keeping only what
    # passes the mod's own ValidateAsFuel.
    Then Manure Composting: Burn It for Fuel's default fuels allow "DryManure"
    And no errors were logged
