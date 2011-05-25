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

  @password @form
    Scenario: Wrong credentials
    Given I am on the homepage
    And I follow "Sign in"
    Then I should be on the new user session page
    When I fill in "user_login" with "alzheimer"
    And I fill in "user_password" with "i dunno"
    And I press "Sign in"
    Then I should be on the new user session page

  @password @form
    Scenario: Reset Password
    Given I am on the new user session page
    Given there is an user "alzheimer"
    When I follow "Forgot your password?"
    Then I should be on the new user password page
    When I fill in "user_email" with "alzheimer@test.com"
    And I press localized "devise.passwords.reset_button"
    Then I should be on the new user session page