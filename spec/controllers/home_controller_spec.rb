require 'spec_helper'
require_relative '../../lib/utilities/recommendations/recommender'

describe HomeController do

  context "sign in fake user" do
    before(:each) do
      @user = stub(:user)
      sign_in @user
    end
  end

  it "should return movie of the day in index" do
    recommender = stub(:rec)
    ObjectContainer.stub(:get).and_return(recommender)
    recommender.stub(:recommendations_for)
    Movie.should_receive(:find_movie_of_the_day).and_return(Movie.new(:title => "Die Hard"))
    get :index
  end

  it "should return movie list by title when called with no  params" do
    Movie.stub(:find_movie_of_the_day)
    recommender = stub(:rec)
    ObjectContainer.stub(:get).and_return(recommender)
    recommender.stub(:recommendations_for)
    Movie.should_receive(:retrieve_sorted_by).with(:title)
    get :index
  end

  it "should return movie list by the property passed" do
    Movie.stub(:find_movie_of_the_day)
    recommender = stub(:rec)
    ObjectContainer.stub(:get).and_return(recommender)
    recommender.stub(:recommendations_for)
    Movie.should_receive(:retrieve_sorted_by).with(:"indicators.couple_chemistry")
    get :index, :sort_by => "indicators.couple_chemistry"
  end

  it "should return movie recommendations for user if current user exist" do
    recommender = mock(:recommender)
    ObjectContainer.should_receive(:get).with(:recommender).and_return(recommender)
    recommender.should_receive(:recommendations_for).with @user

    get :index
  end
end
