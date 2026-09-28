Feature: Manure Composting - the second composter in a running game

  Background:
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs

  Scenario: the Hygiene architect tab groups the two composters under one button
    Then Manure Composting: the Hygiene architect tab offers one dropdown holding both composters
    And no errors were logged

  Scenario: a colonist finds the manure composter and fills it
    Given the temperature at (146, 158) is above 0
    And a "Nelim_ManureComposter" is built at (146, 158)
    And Manure Composting: 30 manure lies at (144, 158)
    And a colonist "Ada" exists
    And I set "Ada" priority "Hauling" to 1
    When game speed is ultrafast
    Then Manure Composting: the composter at (146, 158) holds 30 manure
    And Manure Composting: the inspect text of the composter at (146, 158) names manure 30 of 250
    And no errors were logged

  Scenario: a finished manure composter is emptied by a colonist and yields biosolids
    Given the temperature at (146, 158) is above 0
    And a "Nelim_ManureComposter" is built at (146, 158)
    And Manure Composting: 30 manure lies at (144, 158)
    And a colonist "Ada" exists
    And I set "Ada" priority "Hauling" to 1
    When game speed is ultrafast
    Then Manure Composting: the composter at (146, 158) holds 30 manure
    When Manure Composting: the development control finishes the composter at (146, 158)
    Then Manure Composting: the map ends up holding 30 "Biosolids"
    And Manure Composting: the composter at (146, 158) is empty
    And no errors were logged
