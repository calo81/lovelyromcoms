Feature: As an admin
  I can edit movies

  Background:
    Given movie with title "10 Things I Hate About You" is registered

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
    When I follow "Movie Edition"
    And I follow "10 Things I Hate About You"
    Then I should see "http://newurl" in field "actor_1_url"

  Scenario: I can  change  the actor name
    Given there are the following confirmed users:
      | email              | password | admin |
      | admin@ticketee.com | password | true  |
    And I am signed in as them
    Given I am on the homepage
    When I follow "Movie Edition"
    And I follow "10 Things I Hate About You"
    And I fill in "actor_1_name" with "Felipe Suarez"
    And  I press "Update Movie"
    Then I should see "Movie Updated"
    When I follow "Movie Edition"
    And I follow "10 Things I Hate About You"
    Then I should see "Felipe Suarez" in field "actor_1_name"

  Scenario: I can  change  the actor 2 image url
    Given there are the following confirmed users:
      | email              | password | admin |
      | admin@ticketee.com | password | true  |
    And I am signed in as them
    Given I am on the homepage
    When I follow "Movie Edition"
    And I follow "10 Things I Hate About You"
    And I fill in "actor_2_url" with "http://newurl"
    And  I press "Update Movie"
    Then I should see "Movie Updated"
    When I follow "Movie Edition"
    And I follow "10 Things I Hate About You"
    Then I should see "http://newurl" in field "actor_2_url"

  Scenario: I can  change  the actor 2 name
    Given there are the following confirmed users:
      | email              | password | admin |
      | admin@ticketee.com | password | true  |
    And I am signed in as them
    Given I am on the homepage
    When I follow "Movie Edition"
    And I follow "10 Things I Hate About You"
    And I fill in "actor_2_name" with "Felipe Suarez"
    And  I press "Update Movie"
    Then I should see "Movie Updated"
    When I follow "Movie Edition"
    And I follow "10 Things I Hate About You"
    Then I should see "Felipe Suarez" in field "actor_2_name"

  Scenario: I can  change  the movie summary
    Given there are the following confirmed users:
      | email              | password | admin |
      | admin@ticketee.com | password | true  |
    And I am signed in as them
    Given I am on the homepage
    When I follow "Movie Edition"
    And I follow "10 Things I Hate About You"
    And I fill in "movie_synopsis" with "Que peliculon"
    And  I press "Update Movie"
    Then I should see "Movie Updated"
    When I follow "Movie Edition"
    And I follow "10 Things I Hate About You"
    Then I should see "Que peliculon" in field "movie_synopsis"

   Scenario: I can  change  the movie trailer url
    Given there are the following confirmed users:
      | email              | password | admin |
      | admin@ticketee.com | password | true  |
    And I am signed in as them
    Given I am on the homepage
    When I follow "Movie Edition"
    And I follow "10 Things I Hate About You"
    And I fill in "movie_trailer" with "http://trailer.com"
    And  I press "Update Movie"
    Then I should see "Movie Updated"
    When I follow "Movie Edition"
    And I follow "10 Things I Hate About You"
    Then I should see "http://trailer.com" in field "movie_trailer"

  Scenario: I can delete the movie
    Given there are the following confirmed users:
      | email              | password | admin |
      | admin@ticketee.com | password | true  |
    And I am signed in as them
    Given I am on the homepage
    When I follow "Movie Edition"
    And I follow "10 Things I Hate About You"
    And  I follow "Delete Movie"
    Then I should see "Movie Deleted"
    When I follow "Movie Edition"
    And I should not see "10 Things I Hate About You"


