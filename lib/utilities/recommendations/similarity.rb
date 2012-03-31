require_relative 'mongo_similarity_persister'
require_relative '../thread_pool'
class Similarity
  attr_reader :user_similarity_list
  attr_accessor :similarity_persist_strategy

  def initialize(extractor, persister)
    @extractor = extractor
    @user_similarity_list = {}
    @similarity_persist_strategy = persister
  end

  def generate_similarities
    users = @extractor.extract_users
    puts users.size
    users.each_with_index do |user_1, index|
      generate_similarity_for_user(index, user_1, users)
    end
    puts "similarity generated"
  end

  private

  def generate_similarity_for_user(index, user_1, users)
    user_1_rankings = @extractor.extract_movies_with_rankings(user_1)
    users.each do |user_2|
      similarity_between_two_users(user_1, user_1_rankings, user_2)
    end
    puts "Number #{index} User #{user_1} similarity done"
  end

  def similarity_between_two_users(user_1, user_1_rankings, user_2)
    common_items = 0
    similarity=0.0;
    user_2_rankings = @extractor.extract_movies_with_rankings(user_2)
    user_1_rankings.each do |ranking_1|
      if (@extractor.user_movie_ranking[user_2+"MM"+ranking_1['movie']])
        common_items += 1
        similarity += (ranking_1['rating'].to_i-@extractor.user_movie_ranking[user_2+"MM"+ranking_1['movie']].to_i)**2
      end
    end
    if common_items>0
      similarity = Math.sqrt(similarity/common_items)
      similarity = 1.0 - Math.tanh(similarity)
      max_common_items = [user_1_rankings.size, user_2_rankings.size].min
      similarity = similarity * (common_items.to_f/max_common_items.to_f) if max_common_items > 10
    end
    @user_similarity_list[user_1+'UU'+user_2] = similarity
    @similarity_persist_strategy.persist(user_1, user_2, similarity)
    puts "persisted #{user_1}, #{user_2}, #{similarity}"
  end
end
