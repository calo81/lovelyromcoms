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
end
