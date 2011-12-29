Feature:
  As a user
  I can access the movie page

Scenario: As a user when on the movie page I can see all the movie information
  Given I am on /movies/770680214/edit
  Then I should see "17 Again"
  And I should see "On the brink of a midlife crisis"



Scenario: User cannot set any value  if not logged in
  Given I am on /movie/edit/10041
  Then the field couple_chemistry doesn't exist
  And the field he_handsometer doesn't exist
  And the field she_handsometer doesn't exist
  And the field dreamy_location doesn't exist
  And the field tear_rate doesn't exist
  And the field happy_ending doesn't exist
  And the field fun_factor doesn't exist
  And the field real_life_likeness doesn't exist
  And the field sex_scenes doesn't exist

Scenario: User can set values  if logged in
  Given I am logged in
  And I am on the homepage
  Then the field couple_chemistry exist
  And the field he_handsometer exist
  And the field she_handsometer exist
  And the field dreamy_location exist
  And the field tear_rate exist
  And the field happy_ending exist
  And the field fun_factor exist
  And the field real_life_likeness exist
  And the field sex_scenes exist
