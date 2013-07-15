require 'mongo'
conn = Mongo::Connection.new('localhost', 27017)
db   = conn['lovelyromcoms_development']
coll = db['movies']

count = coll.count

File.open("input.txt","w") do |file|
  (0..count).each do |number|
    file.puts number+1
  end
end