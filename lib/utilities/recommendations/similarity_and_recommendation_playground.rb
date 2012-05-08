require_relative 'recommender'
require_relative 'similarity'
require_relative 'file_ratings_extractor'
require_relative 'mongo_backed_similarity_data'
require 'rails'
extractor = FileRatingsExtractor.new('/Users/cscarioni/projects/lovelyromcoms/lib/utilities/recommendations/mapreduce/data_preparation/recommendation_feed')
#similarity = Similarity.new(extractor, MongoSimilarityPersister.new)
#similarity.generate_similarities

recommender = Recommender.new(extractor, MongoBackedSimilarityData.new)

recommendations = recommender.recommendations_for('45')

puts recommendations