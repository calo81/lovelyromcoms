require "searcher"
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
    @movie.set_indicators_for_user(user, params["movie"]["indicators"])
    redirect_to edit_movie_path(@movie)
  end

  def index
    @movie_list = if (params[:sort_by].nil?)
                    Movie.retrieve_sorted_by(:title)
                  else
                    Movie.retrieve_sorted_by(params[:sort_by].to_sym, :desc)
                  end
    @movie_list_json = @movie_list.as_json
    @movie_list_json.each do |movie|
      movie["id"]=movie["id"].to_s
    end
    @movie_list_json = @movie_list_json.to_json
  end

  def search
    @movie_list = MovieSearcher.search(params[:q])
    to_return = []
    @movie_list.each do |movie|
      to_return << "#{movie['title']}:::http://multiplantas.com/wp-content/uploads/2011/04/fresa.jpg" if movie["matched_by"] == :title
      to_return << "#{movie["actor"][0]}, Actor,  #{movie["title"]}:::http://multiplantas.com/wp-content/uploads/2011/04/fresa.jpg" if movie["matched_by"] == :actor
    end
    render :json => to_return
  end
end
