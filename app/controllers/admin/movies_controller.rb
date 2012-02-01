class Admin::MoviesController < ApplicationController
  def index
    @movies = Movie.retrieve_sorted_by("title", :asc)
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.abridged_cast[0]["image"] = params[:movie][:abridged_cast]["0"][:image]
    @movie.save!
    flash[:notice] = "Movie Updated"
    render "edit"
  end
end
