require 'spec_helper'

describe Movie do
  it "finds movie of the day" do
    movie = Movie.find_movie_of_the_day
    movie.should_not be_nil
    movie['title'].should_not be_nil
  end
end
