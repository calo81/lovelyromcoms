class Admin::MoviesController < ApplicationController
  def index
    @movies = Movie.retrieve_sorted_by("title", :asc)
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update_attributes(params[:movie])
    update_cast(@movie, params)
    @movie.save!
    flash[:notice] = "Movie Updated"
    render "edit"
  end

  def destroy
    Movie.find(params[:id]).destroy
    flash[:notice] = "Movie Deleted"
    redirect_to admin_movies_path
  end

  private
  def update_cast(movie, params)
    2.times do |time|
      movie.abridged_cast[time]["image"] = params[:abridged_cast][time.to_s][:image]
      movie.abridged_cast[time]["name"] = params[:abridged_cast][time.to_s][:name]
    end
  end
end
