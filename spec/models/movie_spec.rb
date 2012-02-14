require 'spec_helper'

describe Movie do
  it "finds movie of the day" do
    movie = Movie.find_movie_of_the_day
    movie.should_not be_nil
    movie['title'].should_not be_nil
  end

  it "finds movie by Rotten Tomatoes ID" do
    movie = Movie.find_by_rotten_id(770680214)
    movie.should_not be_nil
    p movie
    movie['title'].should=='17 again'
  end

  it "finds indicator value for user" do
    movie = Movie.find_by_rotten_id(770680214)
    user = User.new
    user.id = 123
    movie["indicators"] = {"couple_chemistry"=>{"total"=>4, "reviewers"=>[{"id"=>123, "value"=>4}]}}
    value = movie.indicator_for_user("couple_chemistry", user)
    value.should == 4
  end

  it "can set indicators for user and updates indicators" do
    movie = Movie.find_by_rotten_id(770680214)
    user = User.new
    user.id = 12
    movie["indicators"] = {"couple_chemistry"=>{"total"=>4, "reviewers"=>[{"id"=>123, "value"=>4}]}}
    movie.set_indicator_for_user(user, "couple_chemistry", 5)
    movie["indicators"]["couple_chemistry"]["total"].should == 4.5
    movie["indicators"]["couple_chemistry"]["reviewers"][1]["id"].should == 12
    movie["indicators"]["couple_chemistry"]["reviewers"][1]["value"].should == 5
  end

  it "can set many indicators for user at the same time" do
    movie = Movie.find_by_rotten_id(770680214)
    user = User.new
    user.id = 12
    movie["indicators"] = {"couple_chemistry"=>{"total"=>4, "reviewers"=>[{"id"=>123, "value"=>4}]}, "he_handsome"=>{"total"=>4, "reviewers"=>[{"id"=>123, "value"=>4}]}}
    movie.set_indicators_for_user user, "couple_chemistry"=>6, "he_handsome"=>6
    movie["indicators"]["couple_chemistry"]["total"].should == 5
    movie["indicators"]["he_handsome"]["total"].should == 5.0
    movie["indicators"]["couple_chemistry"]["reviewers"][1]["id"].should == 12
    movie["indicators"]["couple_chemistry"]["reviewers"][1]["value"].should == 6
    movie["indicators"]["he_handsome"]["reviewers"][1]["id"].should == 12
    movie["indicators"]["he_handsome"]["reviewers"][1]["value"].should == 6
  end

  it "can set indicator for user replace if he already set those indicators" do
    movie = Movie.find_by_rotten_id(770680214)
    user = User.new
    user.id = 123
    movie["indicators"] = {"couple_chemistry"=>{"total"=>4, "reviewers"=>[{"id"=>123, "value"=>4}]}}
    movie.set_indicators_for_user user, "couple_chemistry"=>5, "he_handsome"=>6
    movie["indicators"]["couple_chemistry"]["total"].should == 5
    movie["indicators"]["he_handsome"]["total"].should == 6
    movie["indicators"]["couple_chemistry"]["reviewers"][0]["id"].should == 123
    movie["indicators"]["couple_chemistry"]["reviewers"][0]["value"].should == 5
    movie["indicators"]["he_handsome"]["reviewers"][0]["id"].should == 123
    movie["indicators"]["he_handsome"]["reviewers"][0]["value"].should == 6
  end

  it "returns a list ordered by title" do
    movies = Movie.retrieve_sorted_by(:title)
    movies.size.should == 10
    comparison = (movies[0].title <=> movies[1].title)
    comparison.should == -1
  end

  it "returns a list ordered by some indicator total" do
    movies = Movie.retrieve_sorted_by("indicators.couple_chemistry.total", :desc)
    movies.size.should == 10
    movies[0].indicators["couple_chemistry"]["total"].should >= movies[1].indicators["couple_chemistry"]["total"]
  end

  it "should return average score for all indicators" do
    movie = Movie.find_by_rotten_id(770680214)
    movie.indicators = {}
    movie.save!
    user = User.new
    user.id = 123
    movie.set_indicators_for_user user, "couple_chemistry"=>5, "he_handsome"=>6
    user = User.new
    user.id = 125
    movie.set_indicators_for_user user, "couple_chemistry"=>2, "he_handsome"=>7
    movie.avg_score.should == 5
  end

  it "should allow to add review per user" do
    movie = Movie.find_by_rotten_id(770680214)
    user = User.new
    user.id = 123
    movie.set_review_for_user user, "This was a great movie"
    user = User.new
    user.id = 125
    movie.set_review_for_user user, "I think it was crap"
    movie.reviews.size.should == 2
    movie.reviews[0]["user_id"].should == 123
    movie.reviews[1]["user_id"].should == 125
    movie.reviews[0]["review"].should == "This was a great movie"
    movie.reviews[1]["review"].should == "I think it was crap"
    movie.review_for_user(user).should ==  "I think it was crap"
  end

end
