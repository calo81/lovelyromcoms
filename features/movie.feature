Feature:
  As a user
  I can access the movie page

Scenario: As a user when on the movie page I can see all the movie information
  Given I am on /movies/770680214/edit
  Then I should see "17 Again"
  And I should see "On the brink of a midlife crisis"


Scenario: Values for the different measures are shown (- when still not reviewed by anyone)
 Given I am on /movies/312815364/edit
 Then I should see "Couple Chemistry: - (0 Reviewers)"
 And I should see "How handsome is he: - (0 Reviewers)"
 And I should see "How pretty is she: - (0 Reviewers)"
 And I should see "Is it a dreamy place: - (0 Reviewers)"
 And I should see "How much did you cry: - (0 Reviewers)"
 And I should see "How happy were you after watching: - (0 Reviewers)"
 And I should see "How fun do you think it was: - (0 Reviewers)"
 And I should see "Is it a real life likely situation: - (0 Reviewers)"
 And I should see "Were the passion scenes good: - (0 Reviewers)"

Scenario: Values for the different measures are shown
 Given I am on /movies/770680214/edit
 When I update the movie 770680214 with indicators '{"couple_chemistry":{"total":4,"reviewers":[{"id":123,"value":4}]},"he_handsome":{"total":6,"reviewers":[{"id":123,"value":6}]},"she_handsome":{"total":8,"reviewers":[{"id":123,"value":8}]},"dream_place":{"total":5,"reviewers":[{"id":123,"value":5}]},"tear_rate":{"total":3,"reviewers":[{"id":123,"value":3}]},"happy_ending":{"total":9,"reviewers":[{"id":123,"value":9}]},"fun_factor":{"total":5,"reviewers":[{"id":123,"value":5}]},"real_life_likely":{"total":5,"reviewers":[{"id":123,"value":5}]},"sex_scenes":{"total":3,"reviewers":[{"id":123,"value":3}]}}'
 Then I should see "Couple Chemistry: 4 (1 Reviewers)"
 And I should see "How handsome is he: 6 (1 Reviewers)"
 And I should see "How pretty is she: 8 (1 Reviewers)"
 And I should see "Is it a dreamy place: 5 (1 Reviewers)"
 And I should see "How much did you cry: 3 (1 Reviewers)"
 And I should see "How happy were you after watching: 9 (1 Reviewers)"
 And I should see "How fun do you think it was: 5 (1 Reviewers)"
 And I should see "Is it a real life likely situation: 5 (1 Reviewers)"
 And I should see "Were the passion scenes good: 3 (1 Reviewers)"
 And I should see css "title" with content "17 Again"


Scenario: User cannot set any value  if not logged in
  Given I am on /movies/770680214/edit
  When I update the movie 770680214 with indicators '{"couple_chemistry":{"total":4,"reviewers":[{"id":123,"value":4}]},"he_handsome":{"total":6,"reviewers":[{"id":123,"value":6}]},"she_handsome":{"total":8,"reviewers":[{"id":123,"value":8}]},"dream_place":{"total":5,"reviewers":[{"id":123,"value":5}]},"tear_rate":{"total":3,"reviewers":[{"id":123,"value":3}]},"happy_ending":{"total":9,"reviewers":[{"id":123,"value":9}]},"fun_factor":{"total":5,"reviewers":[{"id":123,"value":5}]},"real_life_likely":{"total":5,"reviewers":[{"id":123,"value":5}]},"sex_scenes":{"total":3,"reviewers":[{"id":123,"value":3}]}}'
  Then the field couple_chemistry doesn't exist
  And the field he_handsometer doesn't exist
  And the field she_handsometer doesn't exist
  And the field dreamy_location doesn't exist
  And the field tear_rate doesn't exist
  And the field happy_ending doesn't exist
  And the field fun_factor doesn't exist
  And the field real_life_likeness doesn't exist
  And the field sex_scenes doesn't exist
  And the field why_would_you_recommned_it doesn't exist

Scenario: User can set values  if logged in
  Given I am logged in
  And I am on /movies/770680214/edit
  When I update the movie 770680214 with indicators '{"couple_chemistry":{"total":4,"reviewers":[{"id":123,"value":4}]},"he_handsome":{"total":6,"reviewers":[{"id":123,"value":6}]},"she_handsome":{"total":8,"reviewers":[{"id":123,"value":8}]},"dream_place":{"total":5,"reviewers":[{"id":123,"value":5}]},"tear_rate":{"total":3,"reviewers":[{"id":123,"value":3}]},"happy_ending":{"total":9,"reviewers":[{"id":123,"value":9}]},"fun_factor":{"total":5,"reviewers":[{"id":123,"value":5}]},"real_life_likely":{"total":5,"reviewers":[{"id":123,"value":5}]},"sex_scenes":{"total":3,"reviewers":[{"id":123,"value":3}]}}'
  When I update the movie 770680214 field recomendations with '[]'
  Then the field couple_chemistry exist
  And the field he_handsometer exist
  And the field she_handsometer exist
  And the field dreamy_location exist
  And the field tear_rate exist
  And the field happy_ending exist
  And the field fun_factor exist
  And the field real_life_likeness exist
  And the field sex_scenes exist
  And the field why_would_you_recommned_it exist
