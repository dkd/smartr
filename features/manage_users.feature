@user
Feature: Manage users
  @form
  Scenario: Register new user
    Given I am on the homepage
    And I follow "Register"
    Then I should be on the new user registration page
    When I fill in "user_login" with "leander"
    And I fill in "user_email" with "leander.taler@example.com"
    And I fill in "user_password" with "password"
    And I fill in "user_password_confirmation" with "password"
    And I press "Register"
    Then I should be on the homepage
    And I should see "leander" within "#topheader"
    
  @password
  Scenario: Reset Password
    Given there is an user "alzheimer"
    Given I am on the homepage
    And I follow "Sign in"
    Then I should be on the new user session page
    When I fill in "user_login" with "alzheimer"
    And I fill in "user_password" with "i dunno"
    And I press "Sign in"
    Then I should be on the new user password page