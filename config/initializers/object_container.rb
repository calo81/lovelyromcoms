require 'recommendations'
require 'utilities/rotten_movie_retriever'
require 'utilities/index/indexer'
class ObjectContainer
  @objects = {}

  def self.init
    recommender = setup_recommender()
    movie_retriever = RottenMovieRetriever.new
    @objects[:recommender]=recommender
    @objects[:movie_retriever]=movie_retriever
    @objects[:indexer] = Indexer.new
  end

  def self.setup_recommender
    data_model = Recommendations::DataModel::MongoDataModel.new db: 'recommender', collection: 'items'
    similarity = Recommendations::Similarity::EuclideanDistanceSimilarity.new(data_model)
    neighborhood = Recommendations::Similarity::Neighborhood::NearestNUserNeighborhood.new(data_model, similarity, 5, 0.5, 100)
    rating_estimator = Recommendations::Recommender::Estimation::DefaultRatingEstimator.new(data_model, similarity)
    recommender = Recommendations::Recommender::GenericUserBasedRecommender.new(data_model, similarity, neighborhood, rating_estimator)
    recommender.activate_cache
    recommender
  end

  def self.get(name)
    @objects[name]
  end
end

ObjectContainer.init