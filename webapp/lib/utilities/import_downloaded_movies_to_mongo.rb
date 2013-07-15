require 'mongo'

@db = Mongo::Connection.new.db("lovelyromcoms_development")
@movie_collection = @db['movies']

Dir.entries('movies').each do |file|
  next if (file.start_with?("."))
  File.open("movies/#{file}") do |f|
    f.each_line do |line|
      @movie_collection.insert(eval(line))
    end
  end
end