Feature: Manure Composting - a filled composter across a save and a reload

  Background:
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs

  Scenario: a manure composter keeps its contents through a save and a reload
    Given the temperature at (146, 158) is above 0
    And a "Nelim_ManureComposter" is built at (146, 158)
    And Manure Composting: 30 manure lies at (144, 158)
    And a colonist "Ada" exists
    And I set "Ada" priority "Hauling" to 1
    When game speed is ultrafast
    Then Manure Composting: the composter at (146, 158) holds 30 manure
    When game speed is paused
    And I save and reload
    Then Manure Composting: the composter at (146, 158) holds 30 manure
    And Manure Composting: the inspect text of the composter at (146, 158) names manure 30 of 250
    And no errors were logged
