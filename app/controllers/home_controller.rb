class HomeController < ApplicationController
  def index
      @movie_of_the_day = Movie.find_movie_of_the_day
      @movie_list = Movie.retrieve_sorted_by(:title)
  end
end
