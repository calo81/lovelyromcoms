class HomeController < ApplicationController
  def index
    @movie_of_the_day = Movie.find_movie_of_the_day
    movie_list
  end

  private
  def movie_list
    @movie_list = if (params[:sort_by].nil?)
                    Movie.retrieve_sorted_by(:title)
                  else
                    Movie.retrieve_sorted_by(params[:sort_by].to_sym)
                  end
  end
end
