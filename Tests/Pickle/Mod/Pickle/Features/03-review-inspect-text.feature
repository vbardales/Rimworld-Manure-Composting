Feature: Manure Composting - the inspect pane in the language of the pass

  Background:
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs

  @review
  Scenario: the inspect pane and the development control speak the language of the game
    Given the temperature at (146, 158) is above 0
    And a "Nelim_ManureComposter" is built at (146, 158)
    And Manure Composting: 30 manure lies at (144, 158)
    And a colonist "Ada" exists
    And I set "Ada" priority "Hauling" to 1
    When game speed is ultrafast
    Then Manure Composting: the composter at (146, 158) holds 30 manure
    When game speed is paused
    And Manure Composting: I select the composter at (146, 158) and look at it
    Then Manure Composting: the inspect text of the composter at (146, 158) names manure 30 of 250
    When I take a screenshot "manure-composter-filling"
    And Manure Composting: the development control finishes the composter at (146, 158)
    And Manure Composting: I select the composter at (146, 158) and look at it
    Then Manure Composting: the composter at (146, 158) is finished
    When I take a screenshot "manure-composter-composted"
    Then no errors were logged
