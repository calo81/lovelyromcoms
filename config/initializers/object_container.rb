require 'utilities/recommendations/mongo_backed_similarity_data'
require 'utilities/recommendations/mongo_backed_recommender'
require 'utilities/recommendations/id_to_movie_recommender'
class ObjectContainer
  @objects = {}

  def self.init
    extractor = FileRatingsExtractor.new(Rails.root + 'lib/utilities/recommendations/mapreduce/data_preparation/recommendation_feed')
    recommender = Recommender.new(extractor, MongoBackedSimilarityData.new)
    mongo_recommender =  MongoBackedRecommender.new recommender
    id_to_movie_recommender = IdToMovieRecommender.new mongo_recommender
    @objects[:recommender]=id_to_movie_recommender
  end

  def self.get(name)
    @objects[name]
  end
end

ObjectContainer.init