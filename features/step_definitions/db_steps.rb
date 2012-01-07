When /^I update the movie ([0-9]+) with indicators '([a-zA-Z \:0-9"_,\{\}\[\]]+)'$/ do |movie_id,indicator_hash|
  indicator_hash.gsub!("\:","=>")
  indicators = eval(indicator_hash)
  movie = Movie.find_by_rotten_id(movie_id.to_i)
  movie["indicators"]=indicators
  movie.save!
end

When /^I update the movie ([0-9]+) field ([a-z_]+) with '([a-zA-Z \:0-9"_,\{\}\[\]]+)'$/ do |movie_id,field,hash|
  hash.gsub!("\:","=>")
  value = eval(hash)
  movie = Movie.find_by_rotten_id(movie_id.to_i)
  movie[field]=value
  movie.save!
end