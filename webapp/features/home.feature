Feature: Home page
  As a user
  I want to access the home page

Background: 
  Given movie with title "Die hard" is registered

Scenario: Texts visible in home
  Given I am on the homepage
  Then user can see "Top 10" text in the page
  And user can see "Movie of the day" text in the page
  And user can see "Recommendations" text in the page



Scenario: I can click in the movie title and go to the movie page
  Given I am on the homepage
  When I follow movie_of_the_day_link
  Then I should see "Trailer"

Scenario: I can see a list of movies
  Given I am on the homepage
  Then I should see elements with class "title_in_list" at least 1 times

Scenario: If  logged in I can see a personalized recommendations
  Given I am logged in as "carlo@sca.com"
  And recommendations for user "carlo@sca.com" are as follows:
        |movie              |rating  |
        |17 Again           |4.0     |
        |Casanova           |3.5     |
  When I am on the homepage
  Then I should see "17 Again" within ".recommendations_table"
  And I should see "Casanova" within ".recommendations_table"
  And show me the page

