Feature: Home page
  As a user
  I want to access the home page

Scenario: Texts visible in home
  Given I am on the homepage
  Then user can see "List of Movies" text in the page
  And user can see "Movie of the day" text in the page
  And user can see "Recommended to you" text in the page



Scenario: I can click in the movie title and go to the movie page
  Given I am on the homepage
  When I follow movie_of_the_day_link
  Then I should see "Trailer"
