require 'spec_helper'

describe HomeController do
  before(:each) do
    @controller = HomeController.new
  end

  it "should return movie of the day in index" do
      Movie.should_receive(:find_movie_of_the_day).and_return(Movie.new(:title => "Die Hard"))
      @controller.index
  end
end
