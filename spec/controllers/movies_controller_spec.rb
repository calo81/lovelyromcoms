require 'spec_helper'
require File.expand_path("../../../lib/searcher", __FILE__)

describe MoviesController do
  before(:each) do
    @controller = MoviesController.new
    @controller.params = {:id=>1}
  end

  it "should load a movie by ID" do
    movie = mock('movie')
    movie.stub(:[])
    movie.stub(:[]=)
    Movie.should_receive(:find_by_rotten_id).with(1).and_return(movie)
    @controller.edit
    @controller.instance_variable_get("@movie").should == movie
  end

  it "should return a list of movies JSON with id is String" do
    @controller.index
    @controller.instance_variable_get("@movie_list_json").should_not be_nil
    movie_list_json = @controller.instance_variable_get("@movie_list_json")
    movie_list_json = JSON.parse(movie_list_json)
    movie_list_json.each do |movie|
      movie["id"].class.should == String
    end
  end

  it "should update movie with user indicators" do
    @controller.params = {"movie"=>{"review"=>"good movie","indicators"=>{"couple_chemistry"=>"2", "she_handsometer"=>"3", "he_handsometer"=>"4", "dreamy_location"=>"5", "tear_rate"=>"6", "happy_ending"=>"7", "fun_factor"=>"8", "real_life_likeness"=>"9", "sex_scenes"=>"0"}}}
    user = mock("user")
    movie = mock("movie")
    stripped_hash = {"couple_chemistry"=>"2", "she_handsometer"=>"3", "he_handsometer"=>"4", "dreamy_location"=>"5", "tear_rate"=>"6", "happy_ending"=>"7", "fun_factor"=>"8", "real_life_likeness"=>"9", "sex_scenes"=>"0"}
    @controller.should_receive(:current_user).and_return user
    Movie.should_receive(:find).and_return movie
    movie.should_receive(:set_indicators_for_user).with(user, stripped_hash)
    movie.should_receive(:set_review_for_user).with(user,"good movie")
    movie.should_receive(:save!)
    @controller.should_receive(:edit_movie_path).and_return "path"
    @controller.should_receive(:redirect_to).with("path")
    @controller.update
  end

  it "should allow for searching with full text searching" do
    MovieSearcher.should_receive(:search).with("Die").and_return([{"title"=>"17 Again", "id"=>"1", "actor"=>["Chandler", "Bruce Almighty"]}])
    get :search, :q=>"Die", :remote=>true
    @controller.instance_variable_get("@movie_list").should == [{"title"=>"17 Again", "id"=>"1", "actor"=>["Chandler", "Bruce Almighty"]}]
  end
end
