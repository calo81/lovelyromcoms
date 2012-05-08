class HomeController < ApplicationController
  inject :recommender

  def index
    @movie_of_the_day = Movie.find_movie_of_the_day
    recommendations
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

  def recommendations
    if current_user
      @recommended_movies = recommender.recommendations_for(current_user.id.to_s)
    else
      @recommended_movies = Movie.top_by_critics_rating(5).map {|movie|[movie,4]}
    end
  end
end
