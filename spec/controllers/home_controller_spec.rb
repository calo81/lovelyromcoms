require 'spec_helper'

describe HomeController do
  it "should return movie of the day in index" do
      Movie.should_receive(:find_movie_of_the_day).and_return(Movie.new(:title => "Die Hard"))
      get :index
  end

    it "should return movie list by title when called with no  params" do
      Movie.stub(:find_movie_of_the_day)
      Movie.should_receive(:retrieve_sorted_by).with(:title)
      get :index
    end

    it "should return movie list by the property passed" do
      Movie.stub(:find_movie_of_the_day)
      Movie.should_receive(:retrieve_sorted_by).with(:"indicators.couple_chemistry")
      get :index, :sort_by => "indicators.couple_chemistry"
    end
end
