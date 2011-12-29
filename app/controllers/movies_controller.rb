class MoviesController < ApplicationController
  def edit
    @movie= Movie.find(params[:id])
    if !@movie
      @movie = Movie.find_by_rotten_id(params[:id].to_i)
    end
  end
end
