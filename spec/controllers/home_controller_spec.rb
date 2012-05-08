require 'spec_helper'
require_relative '../../lib/utilities/recommendations/recommender'

describe HomeController do

  let(:user) do
    user = Factory(:user)
    user.confirm!
    user
  end

  before(:each) do
    sign_in :user, user
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
      @controller.should_receive(:recommender).and_return(recommender)
      recommender.should_receive(:recommendations_for)

      get :index
  end

  it "should return top movies by ranking for recommendations when no current user exist" do
    sign_out  user
    Movie.should_receive(:top_by_critics_rating).with(5).and_return([1,2,3,4,5])
    get :index
    recommendations = @controller.instance_variable_get("@recommended_movies")
    recommendations.each_with_index do |recommendation,i|
      recommendation[0].should == i+1
      recommendation[1].should == 4
    end
  end
end
