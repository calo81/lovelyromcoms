class IdToMovieRecommender

  def initialize(recommender)
    @wrapped_recommender = recommender
  end

  def recommendations_for(user)
    recommendations = @wrapped_recommender.recommendations_for(user)
    recommendations.map {|recommendation| [Movie.find(recommendation[0]),recommendation[1]]}
  end
end