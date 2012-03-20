class ObjectContainer
  @objects = {}

  def self.init
    extractor = FileRatingsExtractor.new('/Users/cscarioni/projects/lovelyromcoms/lib/utilities/recommendations/mapreduce/data_preparation/recommendation_feed')
    recommender = Recommender.new(extractor, MongoBackedSimilarityData.new)
    @objects[:recommender]=recommender
  end

  def self.get(name)
    @objects[name]
  end
end

class MongoBackedSimilarityData
  require 'mongo'

  def initialize
    conn = Mongo::Connection.new('localhost', 27017)
    db = conn['lovelyromcoms_development']
    @coll = db['similarities']
  end

  def [](key)
    columns = key.split("UU")
    @coll.find("user_1"=>columns[0],"user_2"=>columns[1]).each {|row| return row["similarity"].to_f}
  end
end

ObjectContainer.init