class MongoBackedRecommender

  def initialize(recommender)
    @wrapped_recommender = recommender
    conn = Mongo::Connection.new('localhost', 27017)
    db = conn["lovelyromcoms_#{Rails.env}"]
    @coll = db['recommendations']
  end

  def recommendations_for(user)
    recommendations = @coll.find({"user"=>user.to_s}).map { |row|  [row["movie"].to_s,row["estimated_rating"]] }
    recommendations = retrieve_from_wrapped_recommender(recommendations, user) unless(Rails.env == "test")
    recommendations.delete_if {|tuple| tuple[1].to_i == 0}
  end

  private


  def retrieve_from_wrapped_recommender(recommendations, user)
    if !recommendations or recommendations.empty?
      recommendations = @wrapped_recommender.recommendations_for(user)
      recommendations.each do |recommendation|
        @coll.insert({"user"=>user, "movie"=>recommendation[0], "estimated_rating"=>recommendation[1]})
      end
    end
    recommendations
  end
end