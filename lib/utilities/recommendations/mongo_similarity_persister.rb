require 'mongo'
class MongoSimilarityPersister
  def initialize
    conn = Mongo::Connection.new('localhost', 27017)
    db = conn['lovelyromcoms_development']
    @coll = db['similarities']
  end

  def persist(user_1,user_2,similarity)
     @coll.insert({user_1: user_1, user_2: user_2, similarity: similarity})
  end
end