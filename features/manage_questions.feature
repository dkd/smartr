@question
Feature: Manage questions

  @form @authenticated
  Scenario: Add new question
    Given I am an authenticated user "leander"
    When I am on the homepage
    And I follow localized "sidebar.ask_a_question"
    Then I should be on the new question page
    When I fill in "question_name" with "How many tests do I have to write?"
    And I fill in "wmd-input" with "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    And I fill in "question_tag_list" with "cucumber, testing"
    And I press localized "question.save"
    Then I should be on the question page
    And I should see "How many tests do I have to write?"
    And I should see "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor"
    When I follow localized "main_menu.questions"
    Then I should see "How many tests do I have to write?"
    And I should see "cucumber"
    And I should see "testing"
  #Scenario: Edit question
    