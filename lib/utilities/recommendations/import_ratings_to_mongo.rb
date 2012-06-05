require 'mongo'

@db = Mongo::Connection.new.db("lovelyromcoms_development")
@movie_collection = @db['ratings']

File.open("mapreduce/data_preparation/recommendation_feed")  do |f|
  f.each_line do |line|
    user, item, preference = line.split("|")
    preference.chop!
    @movie_collection.insert({:user_id=>user, :item_id=>item, :preference=>preference})
  end
end