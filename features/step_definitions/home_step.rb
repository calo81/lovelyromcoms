And /^user can see movie of the day title is the same as retrieved from DB$/ do
  page.has_content?(Movie.find_movie_of_the_day.title).should be_true
end

And /^user can see movie of the day both main characters names in the page$/ do
  movie = Movie.find_movie_of_the_day
  main_character1 = movie.abridged_cast[0]['name']
  main_character2 = movie.abridged_cast[1]['name']
  page.has_content?(main_character1).should be_true
  page.has_content?(main_character2).should be_true
end