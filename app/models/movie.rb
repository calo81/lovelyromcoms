class Movie
  include MongoMapper::Document
  def self.find_movie_of_the_day
    all[Random.rand(all.count)]
  end
end