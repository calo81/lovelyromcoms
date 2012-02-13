Feature:
  As a user
  I can access the movie page

Background:
  Given movie with title "17 again" is registered with id "770685555"
  Given movie with title "Die Hard" is registered with id "312815364"

Scenario: As a user when on the movie page I can see all the movie information
  Given I am on /movies/770685555/edit
  Then I should see "17 again"
  And I should see "A successful Los Angeles"
  And I should see "Violetta Arlak"
  And I should see "Andrzej Blumenfeld"


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
 Given I update the movie 770685555 with indicators '{"couple_chemistry":{"total":4,"reviewers":[{"id":123,"value":4}]},"he_handsome":{"total":6,"reviewers":[{"id":123,"value":6}]},"she_handsome":{"total":8,"reviewers":[{"id":123,"value":8}]},"dream_place":{"total":5,"reviewers":[{"id":123,"value":5}]},"tear_rate":{"total":3,"reviewers":[{"id":123,"value":3}]},"happy_ending":{"total":9,"reviewers":[{"id":123,"value":9}]},"fun_factor":{"total":5,"reviewers":[{"id":123,"value":5}]},"real_life_likely":{"total":5,"reviewers":[{"id":123,"value":5}]},"sex_scenes":{"total":3,"reviewers":[{"id":123,"value":3}]}}'
 And I am on /movies/770685555/edit
 Then I should see "Couple Chemistry: 4 (1 Reviewers)"
 And I should see "How handsome is he: 6 (1 Reviewers)"
 And I should see "How pretty is she: 8 (1 Reviewers)"
 And I should see "Is it a dreamy place: 5 (1 Reviewers)"
 And I should see "How much did you cry: 3 (1 Reviewers)"
 And I should see "How happy were you after watching: 9 (1 Reviewers)"
 And I should see "How fun do you think it was: 5 (1 Reviewers)"
 And I should see "Is it a real life likely situation: 5 (1 Reviewers)"
 And I should see "Were the passion scenes good: 3 (1 Reviewers)"
 And I should see css "title" with content "17 again"


Scenario: User cannot set any value  if not logged in
  Given I update the movie 770685555 with indicators '{"couple_chemistry":{"total":4,"reviewers":[{"id":123,"value":4}]},"he_handsome":{"total":6,"reviewers":[{"id":123,"value":6}]},"she_handsome":{"total":8,"reviewers":[{"id":123,"value":8}]},"dream_place":{"total":5,"reviewers":[{"id":123,"value":5}]},"tear_rate":{"total":3,"reviewers":[{"id":123,"value":3}]},"happy_ending":{"total":9,"reviewers":[{"id":123,"value":9}]},"fun_factor":{"total":5,"reviewers":[{"id":123,"value":5}]},"real_life_likely":{"total":5,"reviewers":[{"id":123,"value":5}]},"sex_scenes":{"total":3,"reviewers":[{"id":123,"value":3}]}}'
  And I am on /movies/770685555/edit
  Then the field couple_chemistry doesn't exist
  And the field he_handsome doesn't exist
  And the field she_handsome doesn't exist
  And the field dream_place doesn't exist
  And the field tear_rate doesn't exist
  And the field happy_ending doesn't exist
  And the field fun_factor doesn't exist
  And the field real_life_likely doesn't exist
  And the field sex_scenes doesn't exist
  And the field why_would_you_recommned_it doesn't exist

Scenario: User can set values  if logged in
  Given I am logged in
  When I update the movie 770685555 with indicators '{"couple_chemistry":{"total":4,"reviewers":[{"id":123,"value":4}]},"he_handsome":{"total":6,"reviewers":[{"id":123,"value":6}]},"she_handsome":{"total":8,"reviewers":[{"id":123,"value":8}]},"dream_place":{"total":5,"reviewers":[{"id":123,"value":5}]},"tear_rate":{"total":3,"reviewers":[{"id":123,"value":3}]},"happy_ending":{"total":9,"reviewers":[{"id":123,"value":9}]},"fun_factor":{"total":5,"reviewers":[{"id":123,"value":5}]},"real_life_likely":{"total":5,"reviewers":[{"id":123,"value":5}]},"sex_scenes":{"total":3,"reviewers":[{"id":123,"value":3}]}}'
  When I update the movie 770685555 field recomendations with '[]'
  And I am on /movies/770685555/edit
  Then the field couple_chemistry exist
  And the field he_handsome exist
  And the field she_handsome exist
  And the field dream_place exist
  And the field tear_rate exist
  And the field happy_ending exist
  And the field fun_factor exist
  And the field real_life_likely exist
  And the field sex_scenes exist
  And the field why_would_you_recommend_it exist
