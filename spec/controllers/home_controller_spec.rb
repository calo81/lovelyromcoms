require 'spec_helper'

describe HomeController do
  before(:each) do
    @controller = HomeController.new
  end

  it "should return movie of the day in index" do
      Movie.should_receive(:find_movie_of_the_day).and_return(Movie.new(:title => "Die Hard"))
      @controller.index
  end

    it "should return movie list by title when called with no  params" do
      Movie.stub(:find_movie_of_the_day)
      Movie.should_receive(:retrieve_sorted_by).with(:title)
      get :index
    end
end
