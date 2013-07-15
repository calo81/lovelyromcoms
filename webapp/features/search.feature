Feature: As a user I can do full text search

Background: In the home page
  Given I am on the homepage

@javascript
Scenario: It show me the options for title in search
  When I fill in "search" with "17"
  Then I should see "17 Again" within ".acSelect"


