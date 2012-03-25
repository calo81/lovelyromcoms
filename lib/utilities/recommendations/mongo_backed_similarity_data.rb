class MongoBackedSimilarityData
  require 'mongo'

  def initialize
    conn = Mongo::Connection.new('localhost', 27017)
    db = conn["lovelyromcoms_#{Rails.env}"]
    @coll = db['similarities']
  end

  def [](key)
    columns = key.split("UU")
    @coll.find("user_1"=>columns[0], "user_2"=>columns[1]).each { |row| return row["similarity"].to_f }
  end
end