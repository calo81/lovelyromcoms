Feature: As a user I can do full text search

Background: In the home page
  Given I am on the homepage
  And movie with title "17 again" is registered with id "770680214"
  And movie with title "Die Hard" is registered with id "312815364"

@javascript
Scenario: It show me the options for title in search
  When I fill in "search" with "17"
  Then I should see "17 again"

