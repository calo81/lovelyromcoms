# encoding: utf-8

def retrieve_user_ratings_for_movie(movie)
   movie["reviews"] ||= []
   movie["reviews"]
end


require 'mongo'
conn = Mongo::Connection.new('localhost', 27017)
db   = conn['lovelyromcoms_development']
coll = db['movies']
ARGF.each do |line|
   begin
     movie = coll.find().skip(line.to_i-1).limit(1).first
     user_ratings = retrieve_user_ratings_for_movie(movie)
     user_ratings.each do |user_rating|
       puts user_rating["user_id"].to_s + "|" + movie["_id"].to_s + "|" + user_rating["review"]["score"].to_s
     end
   rescue
     puts $!
   end
end

