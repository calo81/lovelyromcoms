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

  def retrieve_actor_image(actor_name)
    actor_name_underscore = actor_name.gsub(" ","_")
    actor_name_underscore.gsub!("-","")
    url = "http://www.rottentomatoes.com/celebrity/#{actor_name_underscore}/pictures/"
    curl = Curl::Easy.http_get(url)
    curl.perform
    celebrity_page_html = curl.body_str
    line = celebrity_page_html.scan(/<img.*alt="#{actor_name}".*>/)[0]
    if line
    index1 = line.index("src")+5
    index2 =  line.index("jpg")+3-index1
    return line.slice(index1,index2)
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
    page_html.include?("/genre/Comedy")  and  page_html.include?("/genre/Romance")
  end

  def retrieve_and_store_movies(search_term)
    json_hash = request_and_get_hash(search_term)
    puts json_hash
    total = json_hash["total"].to_i
    if total>0
      movie = request_full_details(json_hash['movies'][0]['id'])
      if movie and movie_is_comedy_romance(movie)
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
    begin
    retriever.retrieve_and_store_movies movie_name
    sleep(0.2)
    rescue
      puts 'error but continuing'
    end
  end
end

