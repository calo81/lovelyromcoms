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
    movie['title'].should=='17 Again'
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
    movie["indicators"]["couple_chemistry"]["total"].should == 9
    movie["indicators"]["couple_chemistry"]["reviewers"][1]["id"].should == 12
    movie["indicators"]["couple_chemistry"]["reviewers"][1]["value"].should == 5
  end

  it "can set many indicators for user at the same time" do
    movie = Movie.find_by_rotten_id(770680214)
    user = User.new
    user.id = 12
    movie["indicators"] = {"couple_chemistry"=>{"total"=>4, "reviewers"=>[{"id"=>123, "value"=>4}]}, "he_handsome"=>{"total"=>4, "reviewers"=>[{"id"=>123, "value"=>4}]}}
    movie.set_indicators_for_user user, "couple_chemistry"=>5, "he_handsome"=>6
    movie["indicators"]["couple_chemistry"]["total"].should == 9
    movie["indicators"]["he_handsome"]["total"].should == 10
    movie["indicators"]["couple_chemistry"]["reviewers"][1]["id"].should == 12
    movie["indicators"]["couple_chemistry"]["reviewers"][1]["value"].should == 5
    movie["indicators"]["he_handsome"]["reviewers"][1]["id"].should == 12
    movie["indicators"]["he_handsome"]["reviewers"][1]["value"].should == 6
  end

  it "can set many indicators for user at the same time" do
    movie = Movie.find_by_rotten_id(770680214)
    user = User.new
    user.id = 12
    movie["indicators"] = {"couple_chemistry"=>{"total"=>4, "reviewers"=>[{"id"=>123, "value"=>4}]}}
    movie.set_indicators_for_user user, "couple_chemistry"=>5, "he_handsome"=>6
    movie["indicators"]["couple_chemistry"]["total"].should == 9
    movie["indicators"]["he_handsome"]["total"].should == 6
    movie["indicators"]["couple_chemistry"]["reviewers"][1]["id"].should == 12
    movie["indicators"]["couple_chemistry"]["reviewers"][1]["value"].should == 5
    movie["indicators"]["he_handsome"]["reviewers"][0]["id"].should == 12
    movie["indicators"]["he_handsome"]["reviewers"][0]["value"].should == 6
  end

  it "returns a list ordered by title" do
    movies = Movie.retrieve_sorted_by(:title, 10, 1)
    movies.size.should == 10
    comparison = (movies[0].title <=> movies[1].title)
    comparison.should == -1
  end

end
