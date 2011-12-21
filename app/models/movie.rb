class Movie
  include MongoMapper::Document
  def self.find_movie_of_the_day
    all[0]
  end
end