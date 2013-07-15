# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
require 'utilities/index/indexer'
User.destroy_all
Movie.destroy_all
@user = User.create!(:email => "carlo.scarioni@gmail.com", :password => "123123")
@user.update_attribute("admin", true)
@user.confirm!

@user_normal = User.create!(:email => "carlo.scarioni2@gmail.com", :password => "123123")
@user_normal.update_attribute("admin", false)
@user_normal.confirm!

Movie.create!({"title" => "17 again", "indicators"=>{"couple_chemistry"=>{"total"=>3}}, "year" => 2008, "genres" => ["Comedy", "Romance"], "mpaa_rating" => "Unrated", "runtime" => 107, "release_dates" => {"theater" => "2008-02-29"}, "ratings" => {"critics_score" => -1, "audience_rating" => "Upright", "audience_score" => 62}, "synopsis" => "A successful Los Angeles lawyer discovers that a short-term affair could have long-term consequences when a woman he had a brief affair with claims that she's currently pregnant with his unborn child.", "posters" => {"thumbnail" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif", "profile" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif", "detailed" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif", "original" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif"}, "abridged_cast" => [{"name" => "Violetta Arlak", "image" => "http://www.team-renegade-racing.co.uk/wp-content/gallery/team-photos/placeholder.jpg"}, {"name" => "Andrzej Blumenfeld", "image" => "http://www.team-renegade-racing.co.uk/wp-content/gallery/team-photos/placeholder.jpg"}, {"name" => "Anna Borowiec"}, {"name" => "Marcin Bosak"}, {"name" => "Wil Bowers"}], "abridged_directors" => [{"name" => "Lukasz Karwowski"}], "alternate_ids" => {"imdb" => "1080930"}, "links" => {"self" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390.json", "alternate" => "http://www.rottentomatoes.com/m/expecting-love/", "cast" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/cast.json", "clips" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/clips.json", "reviews" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/reviews.json", "similar" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/similar.json"}, "rotten_id" => 770680214})
Movie.create!({"title" => "Die hard", "indicators"=>{"couple_chemistry"=>{"total"=>4}}, "year" => 2008, "genres" => ["Comedy", "Romance"], "mpaa_rating" => "Unrated", "runtime" => 107, "release_dates" => {"theater" => "2008-02-29"}, "ratings" => {"critics_score" => -1, "audience_rating" => "Upright", "audience_score" => 62}, "synopsis" => "A successful Los Angeles lawyer discovers that a short-term affair could have long-term consequences when a woman he had a brief affair with claims that she's currently pregnant with his unborn child.", "posters" => {"thumbnail" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif", "profile" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif", "detailed" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif", "original" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif"}, "abridged_cast" => [{"name" => "Violetta Arlak", "image" => "http://www.team-renegade-racing.co.uk/wp-content/gallery/team-photos/placeholder.jpg"}, {"name" => "Andrzej Blumenfeld", "image" => "http://www.team-renegade-racing.co.uk/wp-content/gallery/team-photos/placeholder.jpg"}, {"name" => "Anna Borowiec"}, {"name" => "Marcin Bosak"}, {"name" => "Wil Bowers"}], "abridged_directors" => [{"name" => "Lukasz Karwowski"}], "alternate_ids" => {"imdb" => "1080930"}, "links" => {"self" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390.json", "alternate" => "http://www.rottentomatoes.com/m/expecting-love/", "cast" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/cast.json", "clips" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/clips.json", "reviews" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/reviews.json", "similar" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/similar.json"}, "rotten_id" => 770680215})


Dir.open("#{File.dirname(__FILE__)}/../lib/utilities/movies") do |dir|
  indexer = Indexer.new
  movies = []
  dir.each do |file_name|
    if !File.directory?("#{File.dirname(__FILE__)}/../lib/utilities/movies/#{file_name}")
      File.open("#{File.dirname(__FILE__)}/../lib/utilities/movies/#{file_name}") do |f|
        movies << Movie.create!(eval(f.readline))
      end
    end
  end
  indexer.index movies
end
