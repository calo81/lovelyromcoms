class Admin::MoviesController < ApplicationController
  inject :movie_retriever
  def index
    @movies = Movie.retrieve_sorted_by("title", :asc,2000)
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

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new
    @movie.update_attributes(params[:movie])
    update_cast(@movie, params)
    @movie.save!
    render "edit"
  end

  def import
  end

  def do_import
    movie_name =   params[:movie_to_import]
    movie_name.strip!
    movie_name.gsub!(" ", "+")
    movie_retriever.retrieve_and_store_movies movie_name
  end

  private
  def update_cast(movie, params)
    movie["abridged_cast"] = [] unless  movie["abridged_cast"]
    2.times do |time|
      movie.abridged_cast[time] = {} unless movie.abridged_cast[time]
      movie.abridged_cast[time]["image"] = params[:abridged_cast][time.to_s][:image]
      movie.abridged_cast[time]["name"] = params[:abridged_cast][time.to_s][:name]
    end
  end
end
