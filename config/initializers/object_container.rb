require 'utilities/recommendations/mongo_backed_similarity_data'
require 'utilities/recommendations/mongo_backed_recommender'
class ObjectContainer
  @objects = {}

  def self.init
    extractor = FileRatingsExtractor.new('/home/cscarioni/Documents/workspace/lovelyromcoms/lib/utilities/recommendations/mapreduce/data_preparation/recommendation_feed')
    recommender = Recommender.new(extractor, MongoBackedSimilarityData.new)
    mongo_recommender =  MongoBackedRecommender.new recommender
    @objects[:recommender]=mongo_recommender
  end

  def self.get(name)
    @objects[name]
  end
end

ObjectContainer.init