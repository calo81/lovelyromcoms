Feature: Home page
  As a user
  I want to access the home page

Scenario: Texts visible in home
  Given I am on the homepage
  Then user can see "List of Movies" text in the page
  And user can see "Movie of the day" text in the page
  And user can see "Recommended to you" text in the page



Scenario: Movie of the day show indicators
  Given I am on the homepage
  Then user can see "Movie of the day" text in the page
  And user can see "couple chemistry" text in the page
  And user can see "He handsometer" text in the page
  And user can see "She handsometer" text in the page
  And user can see "Dreamy location" text in the page
  And user can see "Tear rate" text in the page
  And user can see "Happy ending" text in the page
  And user can see "Fun factor" text in the page
  And user can see "Real life likeness" text in the page
  And user can see "Love and sex scenes appeal" text in the page

Scenario: User cannot set any value  if not logged in
  Given I am on the homepage
  Then the field couple_chemistry doesn't exist
