class Recommender

  def initialize(extractor, similarity_data)
    @extractor = extractor
    @data_set = extractor.rankings
    @similarity_data=similarity_data
  end


  def recommendations_for(user)
    movies = @extractor.extract_movies
    recommendations = []
    movies.each do |movie|
      recommendations << [movie, get_estimated_rating_for_movie(movie, user)]
    end
    recommendations.delete_if do |recommendation|
      recommendation[1].nil?
    end
    recommendations.sort! do |e1, e2|
      e1[1]<=>e2[1]
    end
    recommendations.reverse!
  end

  private

  def find_user_rating_for_movie(user, movie)
    movie_rating = @extractor.user_movie_ranking[user+movie]
    if movie_rating.nil?
      return nil
    end
    movie_rating.to_i
  end

  def get_estimated_rating_for_movie(movie, user)
    users = @extractor.extract_users
    similarity_sum = 0.0
    weighted_rating_sum = 0.0
    estimated_rating = 0.0
    if find_user_rating_for_movie(user, movie).nil?
      users.each do |other_user|
        next if other_user == user
        if !find_user_rating_for_movie(other_user, movie).nil?
          similarity = @similarity_data[user+'UU'+other_user]
          next if similarity.nil?
          other_user_rating = find_user_rating_for_movie(other_user, movie)
          weighted_rating = similarity.to_f * other_user_rating.to_f
          weighted_rating_sum += weighted_rating
          similarity_sum += similarity
        end
      end
      if (similarity_sum > 0.0)
        estimated_rating = weighted_rating_sum / similarity_sum
      end
    else
      estimated_rating = nil
    end
    estimated_rating
  end
end