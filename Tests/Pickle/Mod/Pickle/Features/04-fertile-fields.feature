@requires:jamaicancastle.RF.fertilefields
Feature: Manure Composting - Fertile Fields' compost recipes in a real load

  Scenario: the two compost recipes are patched by this mod
    Then def "MakeCompost" was patched by mod "nelim.manurecomposting"
    And def "MakeCompost5" was patched by mod "nelim.manurecomposting"
    And no errors were logged
