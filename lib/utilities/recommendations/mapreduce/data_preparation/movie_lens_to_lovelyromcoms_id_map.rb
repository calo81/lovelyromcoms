require 'mongo'
conn = Mongo::Connection.new('localhost', 27017)
db = conn['lovelyromcoms_development']
coll = db['movies']

def replace_ids_with_titles_in_movie_lens_data
  movie_lens_id_to_title={}
  File.open('/tmp/data/ml-10M100K/movies.dat', 'r') do |file|
    file.each_line do |line|
      begin
        splitted_line = line.split("::")
      rescue
        puts "Error, continuing"
        next
      end
      movie_lens_id_to_title[splitted_line[0]]=splitted_line[1]
    end
  end
  File.open('/tmp/data/ml-10M100K/ratings.dat', 'r') do |file|
    File.open('file_with_title', 'w') do |file_to_save|
      file.each_line do |line|
        splitted_line = line.split("::")
        begin
          file_to_save.puts(splitted_line[0]+"|"+movie_lens_id_to_title[splitted_line[1]]+"|"+splitted_line[2])
        rescue Exception => e
          puts "Error, continuing #{e}"
          next
        end
      end
    end
  end
end

def create_file_with_lovelyromcoms_ids(coll)
  File.open('file_with_title', 'r') do |file|
    File.open('recommendation_feed', 'w') do |file_output|
      coll.find.each do |movie|
        puts movie["title"].downcase
        file.rewind
        file.each_line do |line|
          splitted_line = line.split("|")
          if line.downcase.include?(movie["title"].downcase)
            file_output.puts(splitted_line[0].to_s+"|"+movie['_id'].to_s+"|"+splitted_line[2].to_s)
          end
        end
      end
    end
  end
end

def combine_movie_lens_with_lovelyromcoms_ratings
  File.open('../recommendation_file/part-00000', 'r') do |input_file|
    File.open('recommendation_feed', 'a') do |file_output|
      input_file.each_line do |line|
        file_output.puts line
      end
    end
  end
end

replace_ids_with_titles_in_movie_lens_data
create_file_with_lovelyromcoms_ids(coll)
combine_movie_lens_with_lovelyromcoms_ratings