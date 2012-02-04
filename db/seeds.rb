# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

@user = User.create!(:email => "carlo.scarioni@gmail.com", :password => "123123")
@user.update_attribute("admin",true)
@user.confirm!

@movie = Movie.create!({"title" => "10 Things I Hate About You", "year" => 2008, "genres" => [ "Comedy", "Romance" ], "mpaa_rating" => "Unrated", "runtime" => 107, "release_dates" => { "theater" => "2008-02-29" }, "ratings" => { "critics_score" => -1, "audience_rating" => "Upright", "audience_score" => 62 }, "synopsis" => "A successful Los Angeles lawyer discovers that a short-term affair could have long-term consequences when a woman he had a brief affair with claims that she's currently pregnant with his unborn child.", "posters" => { "thumbnail" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif", "profile" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif", "detailed" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif", "original" => "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif" }, "abridged_cast" => [ 	{ 	"name" => "Violetta Arlak", 	"image" => "http://www.team-renegade-racing.co.uk/wp-content/gallery/team-photos/placeholder.jpg" }, 	{ 	"name" => "Andrzej Blumenfeld", 	"image" => "http://www.team-renegade-racing.co.uk/wp-content/gallery/team-photos/placeholder.jpg" }, 	{ 	"name" => "Anna Borowiec" }, 	{ 	"name" => "Marcin Bosak" }, 	{ 	"name" => "Wil Bowers" } ], "abridged_directors" => [ { "name" => "Lukasz Karwowski" } ], "alternate_ids" => { "imdb" => "1080930" }, "links" => { "self" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390.json", "alternate" => "http://www.rottentomatoes.com/m/expecting-love/", "cast" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/cast.json", "clips" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/clips.json", "reviews" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/reviews.json", "similar" => "http://api.rottentomatoes.com/api/public/v1.0/movies/770728390/similar.json" }, "rotten_id" => 770728390 })
