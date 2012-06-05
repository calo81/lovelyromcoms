require 'curb'
require 'mongo'
require 'active_support'
class RottenMovieRetriever
  ROTTEN_API = "rrmbqvpbr9ujrf4yu855aczv"
  TMDB_API = "c4123ba475b7087ce195800a8e61e29e"

  def initialize
    @db = Mongo::Connection.new.db("lovelyromcoms_development")
    @movie_collection = @db['movies']
  end

  def call_url_and_retrieve_json(url)
    #puts url
    curl = Curl::Easy.http_get(url)
    curl.perform
    json_hash = ActiveSupport::JSON.decode(curl.body_str)
    json_hash
  end

  def request_and_get_hash(search_term)
    url = "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=#{ROTTEN_API}&page_limit=1&page=1&q=#{search_term}"
    call_url_and_retrieve_json(url)
  end

  def request_full_details(movie_id)
    url = "http://api.rottentomatoes.com/api/public/v1.0/movies/#{movie_id}.json?apikey=#{ROTTEN_API}"
    json = call_url_and_retrieve_json(url)
    if json['genres'].include?("Romance") or json['genres'].include?("Comedy")
      return json
    else
      return nil
    end
  end

  def store_movie(movie)
    if movie
      puts "SAVED!!"
      @movie_collection.insert movie
      File.open("#{File.dirname(__FILE__)}/movies/#{movie["rotten_id"]}", "w") do |f|
        f.puts movie.to_s
      end
    end
  end

  def retrieve_actor_image(actor_name)
    actor_name_underscore = actor_name.gsub(" ", "_")
    actor_name_underscore.gsub!("-", "")
    url = "http://www.rottentomatoes.com/celebrity/#{actor_name_underscore}/pictures/"
    curl = Curl::Easy.http_get(url)
    curl.perform
    celebrity_page_html = curl.body_str
    line = celebrity_page_html.scan(/<img.*alt="#{actor_name}".*>/)[0]
    if line
      index1 = line.index("src")+5
      index2 = line.index("jpg")+3-index1
      return line.slice(index1, index2)
    else
      return 'http://www.team-renegade-racing.co.uk/wp-content/gallery/team-photos/placeholder.jpg'
    end
  end

  def extract_imdb_id(movie)
    begin
      movie['alternate_ids']['imdb']
    rescue
      return "XXX"
    end
  end

  def movie_is_comedy_romance(movie)
    #first check if it is already comedy AND romance
    return true if  movie['genres'].include?("Romance") and movie['genres'].include?("Comedy")
    #if not, we consult on IMDB to see if it is comedy and romance
    imdb_id = extract_imdb_id(movie)
    url = "http://www.imdb.com/title/tt#{imdb_id}/"
    curl = Curl::Easy.http_get(url)
    curl.perform
    page_html = curl.body_str
    page_html.include?("/genre/Comedy") and page_html.include?("/genre/Romance")
  end

  def update_movie_synopsis(movie)
    if movie["synopsis"].empty?
      url="http://api.themoviedb.org/2.1/Movie.imdbLookup/en/json/#{TMDB_API}/tt#{extract_imdb_id(movie)}"
      curl = Curl::Easy.http_get(url)
      curl.perform
      json_hash = ActiveSupport::JSON.decode(curl.body_str)
      movie["synopsis"] = json_hash[0]["overview"]
    end
  end

  def update_trailer_url(movie)
    if movie["links"]["clips"] and !movie["links"]["clips"].empty?
      url=movie["links"]["clips"]+"?apikey=rrmbqvpbr9ujrf4yu855aczv"
      curl = Curl::Easy.http_get(url)
      curl.perform
      json_hash = ActiveSupport::JSON.decode(curl.body_str)
      movie["trailer"] = {"image" => json_hash["clips"][0]["thumbnail"], "url" => json_hash["clips"][0]["links"]["alternate"]}
    end
  end

  def remove_nil_properties(movie)
    movie.reject! { |k, v| v.nil? }
  end

  def retrieve_and_store_movies(search_term)
    json_hash = request_and_get_hash(search_term)
    total = json_hash["total"].to_i
    if total>0
      movie = request_full_details(json_hash['movies'][0]['id'])
      movie["rotten_id"] = movie["id"]
      movie["id"]=nil
      remove_nil_properties(movie)
      movie["indicators"]== {}
      if movie and movie_is_comedy_romance(movie)
        update_movie_synopsis(movie)
        update_trailer_url(movie)
        actor1_name = movie['abridged_cast'][0]['name']
        actor2_name = movie['abridged_cast'][1]['name']
        actor1_image = retrieve_actor_image actor1_name
        actor2_image = retrieve_actor_image actor2_name
        movie['abridged_cast'][0]['image']=actor1_image
        movie['abridged_cast'][1]['image']=actor2_image
        store_movie movie
      end
    end
  end
end

retriever=RottenMovieRetriever.new

def execute_full_retrieval
  File.open("mapreduce/results.txt") do |file|
    line_number = 0
    start_in_line = 2993
    file.each_line do |line|
      line_number += 1
      next if line_number<start_in_line
      movie_name = line.split("\t")[0]
      next if movie_name.include?("(VG)")
      movie_name.gsub!('"', "")
      movie_name=movie_name.slice(0..(movie_name.index("(")-1))
      movie_name.strip!
      movie_name.gsub!(" ", "+")
      puts movie_name
      begin
        retriever.retrieve_and_store_movies movie_name
        sleep(0.2)
      rescue
        puts 'error but continuing. Error '+ $!.to_s
      end
    end
  end
end

#execute_full_retrieval