require 'curb'
require 'mongo'
require 'active_support'
class RottenMovieRetriever
  ROTTEN_API = "rrmbqvpbr9ujrf4yu855aczv"

  def initialize
    @db = Mongo::Connection.new.db("lovelyromcoms_development")
    @movie_collection = @db['movies']
  end

  def call_url_and_retrieve_json(url)
    puts url
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
      @movie_collection.insert movie
    end
  end

  def retrieve_and_store_movies(search_term)
    json_hash = request_and_get_hash(search_term)
    puts json_hash
    total = json_hash["total"].to_i
    if total>0
      store_movie(request_full_details(json_hash['movies'][0]['id']))
    end
  end
end

retriever=RottenMovieRetriever.new
File.open("mapreduce/results.txt") do |file|
  file.each_line do |line|
    movie_name = line.split("\t")[0]
    if movie_name.include?("(VG)")
      next
    end
    movie_name.gsub!('"', "")
    movie_name=movie_name.slice(0..(movie_name.index("(")-1))
    movie_name.strip!
    movie_name.gsub!(" ", "+")
    puts movie_name
    retriever.retrieve_and_store_movies movie_name
    sleep(0.2)
  end
end

