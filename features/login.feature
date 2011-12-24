Feature:
  As a user
  I can login to the app


  Scenario: Signing up
    Given I am on the homepage
    When user clicks link "Sign up"
    And user fill in user_email with user@ticketee.com
    And user fill in user_password with password
    And user fill in user_password_confirmation with password
    And user press "Sign up"
    Then user can see "You have signed up successfully" text in the page


  Scenario: When not logged in the form is shown on the page
    When I am on the homepage
    Then the field username exists
    And the field password exists
    And the button login exists