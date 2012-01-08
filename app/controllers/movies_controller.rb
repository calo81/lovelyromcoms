class MoviesController < ApplicationController
  def edit
    @movie= Movie.find(params[:id])
    if !@movie
      @movie = Movie.find_by_rotten_id(params[:id].to_i)
    end
    if !@movie["indicators"]
      @movie["indicators"] = ""
    end
    if !@movie["recomendations"]
      @movie["recomendations"] = ""
    end
  end

  def update
    user = current_user
    @movie= Movie.find(params[:id])
    @movie.set_indicators_for_user(user,params["movie"]["indicators"])
    redirect_to edit_movie_path(@movie)
  end
end
