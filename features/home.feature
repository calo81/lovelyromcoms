Feature: Home page
  As a user
  I want to access the home page

Scenario: Texts visible in home
  Given I am on the homepage
  Then user can see "List of Movies" text in the page
  And user can see "Movie of the day" text in the page
  And user can see "Recommended to you" text in the page
  And user can see movie of the day title is the same as retrieved from DB
  And user can see movie of the day both main characters names in the page