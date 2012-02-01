Feature: As an admin
  I can edit movies

  Scenario: I can access the movie link from home as admin
    Given there are the following confirmed users:
      | email              | password | admin |
      | admin@ticketee.com | password | true  |
    And I am signed in as them
    Given I am on the homepage
    Then I should see "Movie Edition"
    When I follow "Movie Edition"
    Then I should see "Movie Edition"

  Scenario: I cannot access the movie link from home if normal user
    Given there are the following confirmed users:
      | email              | password | admin |
      | admin@ticketee.com | password | false |
    And I am signed in as them
    Given I am on the homepage
    Then I should not see "Movie Edition"


    Scenario: I can  change  the actor image url
    Given there are the following confirmed users:
      | email              | password | admin |
      | admin@ticketee.com | password | true  |
    And I am signed in as them
    Given I am on the homepage
    When I follow "Movie Edition"
    And I follow "10 Things I Hate About You"
    And I fill in "actor_1_url" with "http://newurl"
    And  I press "Update Movie"
    Then I should see "Movie Updated"

