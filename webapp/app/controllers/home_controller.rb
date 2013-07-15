class HomeController < ApplicationController
  inject :recommender

  def index
    @movie_of_the_day = Movie.find_movie_of_the_day
    recommendations
    @movie_list = movie_list("title")
    @movie_list_he_handsome = movie_list("indicators.he_handsome.total")
    @movie_list_she_handsome = movie_list("indicators.she_handsome.total")
  end

  private
  def movie_list(sorted_by)
    list = Movie.retrieve_sorted_by(sorted_by.to_sym)
    return list.map do |movie|
      [movie, movie.avg_score]
    end
  end

  def recommendations
    if current_user
      @recommended_movies = recommender.recommend(current_user.id.to_s, 8)
      @recommended_movies = find_movies_for_each_id_returned(@recommended_movies)
      if !@recommended_movies.nil? and !@recommended_movies.empty?
        return
      end
    end
    @recommended_movies = Movie.top_by_critics_rating(8).map { |movie| [movie, 4] }
  end

  private
  def find_movies_for_each_id_returned(recommended_movies)
    found_movies = []
    recommended_movies.each do |recommendation|
      movie = Movie.find_by_id(recommendation.item)
      found_movies << [movie, recommendation.value] if movie
    end
    found_movies
  end
end
