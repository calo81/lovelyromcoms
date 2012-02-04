Feature:
  As a user
  I can login to the app

 Background:
  Given movie with title "Die hard" is registered

  Scenario: Signing up
    Given I am on the homepage
    When user clicks link "Sign up"
    And user fill in user_email with user@ticketee.com
    And user fill in user_password with password
    And user fill in user_password_confirmation with password
    And user press "Sign up"
    Then user can see "You have signed up successfully" text in the page

  Scenario: Signing in via confirmation
    Given there are the following users:
      | email             | password |
      | user@ticketee.com | password |
    And "user@ticketee.com" opens the email with subject "Confirmation instructions"
    And they click the first link in the email
    Then I should see "Your account was successfully confirmed"
    And I should see "Signed in as user@ticketee.com"


  Scenario: Signing in via form
    Given there are the following confirmed users:
      | email             | password |
      | user@ticketee.com | password |
    And I am on the homepage
    When I follow "Sign in"
    And I fill in "Email" with "user@ticketee.com"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should see "Signed in successfully."