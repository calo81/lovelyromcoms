class MongoBackedRecommender

  def initialize(recommender)
    @wrapped_recommender = recommender
    conn = Mongo::Connection.new('localhost', 27017)
    db = conn["lovelyromcoms_#{Rails.env}"]
    @coll = db['recommendations']
  end

  def recommendations_for(user)
    recommendations = @coll.find({"user"=>user}).map { |row|  [row["movie"],row["estimated_rating"]] }
    if !recommendations or recommendations.empty?
      recommendations = @wrapped_recommender.recommendations_for(user)
      recommendations.each do |recommendation|
        @coll.insert({"user"=>user,"movie"=>recommendation[0],"estimated_rating"=>recommendation[1]})
      end
    end
    recommendations
  end
end