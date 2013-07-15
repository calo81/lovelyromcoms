require 'utilities/index/indexer'
When /^I update the movie ([0-9]+) with indicators '([a-zA-Z \:0-9"_,\{\}\[\]]+)'$/ do |movie_id, indicator_hash|
  indicator_hash.gsub!("\:", "=>")
  indicators = eval(indicator_hash)
  movie = Movie.find_by_rotten_id(movie_id.to_i)
  movie["indicators"]=indicators
  movie.save!
end

When /^I update the movie ([0-9]+) field ([a-z_]+) with '([a-zA-Z \:0-9"_,\{\}\[\]]+)'$/ do |movie_id, field, hash|
  hash.gsub!("\:", "=>")
  value = eval(hash)
  movie = Movie.find_by_rotten_id(movie_id.to_i)
  movie[field]=value
  movie.save!
end

Given /^movie with title "([^"]*)" is registered$/ do |title|
  unless Movie.find_by_title title
    @movie = Movie.create!({"title" => title, "year" => 2008, "genres" => ["Comedy", "Romance"], "mpaa_rating" => "Unrated", "runtime" => 107, "release_dates" => {"theater" => "2008-02-29"}, "ratings" => {"critics_score" => -1, "audience_rating" => "Upright", "audience_score" => 62}, "synopsis" => "A successful Los Angeles lawyer discovers that a short-term affair could have long-term consequences when a woman he had a brief affair with claims that she's currently pregnant with his unborn child.", "posters" => {"thumbnail" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif", "profile" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif", "detailed" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif", "original" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif"}, "abridged_cast" => [{"name" => "Violetta Arlak", "image" => "http://www.teamsdsd.co.uk/wp-content/gallery/team-photos/placeholder.jpg"}, {"name" => "Andrzej Blumenfeld", "image" => "http://www.team-resdfade-racing.co.uk/wp-content/gallery/team-photos/placeholder.jpg"}, {"name" => "Anna Borowiec"}, {"name" => "Marcin Bosak"}, {"name" => "Wil Bowers"}], "abridged_directors" => [{"name" => "Lukasz Karwowski"}], "alternate_ids" => {"imdb" => "1080930"}, "links" => {"self" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390.json", "alternate" => "http://www.rottentomatoes.com/m/expecting-love/", "cast" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/cast.json", "clips" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/clips.json", "reviews" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/reviews.json", "similar" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/similar.json"}, "rotten_id" => 770728390})
  end
end
Given /^movie with title "([^"]*)" is registered with id "([^"]*)"$/ do |title, id|
  @movie = Movie.create!({"id"=>id.to_i,"title" => title, "year" => 2008, "genres" => ["Comedy", "Romance"], "mpaa_rating" => "Unrated", "runtime" => 107, "release_dates" => {"theater" => "2008-02-29"}, "ratings" => {"critics_score" => 35, "audience_rating" => "Upright", "audience_score" => 62}, "synopsis" => "A successful Los Angeles lawyer discovers that a short-term affair could have long-term consequences when a woman he had a brief affair with claims that she's currently pregnant with his unborn child.", "posters" => {"thumbnail" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif", "profile" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif", "detailed" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif", "original" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif"}, "abridged_cast" => [{"name" => "Violetta Arlak", "image" => "http://www.dfdf-racing.co.uk/wp-content/gallery/team-photos/placeholder.jpg"}, {"name" => "Andrzej Blumenfeld", "image" => "http://www.team-rsdgsade-racing.co.uk/wp-content/gallery/team-photos/placeholder.jpg"}, {"name" => "Anna Borowiec"}, {"name" => "Marcin Bosak"}, {"name" => "Wil Bowers"}], "abridged_directors" => [{"name" => "Lukasz Karwowski"}], "alternate_ids" => {"imdb" => "1080930"}, "links" => {"self" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390.json", "alternate" => "http://www.rottentomatoes.com/m/expecting-love/", "cast" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/cast.json", "clips" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/clips.json", "reviews" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/reviews.json", "similar" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/similar.json"}, "rotten_id" => id.to_i})
end

And /^movie with title with id "([^"]*)" is indexed$/ do |id|
  movie = Movie.find(id.to_i)
  Indexer.new.index([movie])
end
