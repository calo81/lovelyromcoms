require 'spec_helper'

describe MoviesController do
  before(:each) do
    @controller = MoviesController.new
    @controller.params = {:id=>1}
  end

  it "should load a movie by ID" do
      movie = mock('movie')
      Movie.should_receive(:find_by_rotten_id).with(1).and_return(movie)
      @controller.edit
      @controller.instance_variable_get("@movie").should == movie
    end
end
