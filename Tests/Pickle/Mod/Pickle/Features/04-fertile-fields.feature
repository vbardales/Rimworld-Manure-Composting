@requires:jamaicancastle.RF.fertilefields
Feature: Manure Composting - Fertile Fields' compost recipes in a real load

  Scenario: the two compost recipes are patched by this mod
    # The step takes the mod display name as the game reports it, not the packageId (same quirk
    # documented in ColorfulCoatsMegafaunaRenew/Tests/Pickle/.../01-patch-applied.feature): a run
    # with the packageId failed both lines with "patched by Manure Composting" in the message,
    # 2026-09-28 ticket 5b50.
    Then def "MakeCompost" was patched by mod "Manure Composting"
    And def "MakeCompost5" was patched by mod "Manure Composting"
    And no errors were logged
