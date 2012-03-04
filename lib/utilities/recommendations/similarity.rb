class Similarity
  attr_reader :user_similarity_list

  def initialize(extractor)
    @extractor = extractor
    @user_similarity_list = {}
  end

  def generate_similarities
    users = @extractor.extract_users
    puts users.size
    users.each_with_index do |user_1,index|
      user_1_rankings = @extractor.extract_movies_with_rankings(user_1)
      users.each do |user_2|
        common_items = 0
        similarity=0.0;
        user_2_rankings = @extractor.extract_movies_with_rankings(user_2)
        user_1_rankings.each do |ranking_1|
          if (!@extractor.user_movie_ranking[user_2+ranking_1['movie']].nil?)
            common_items += 1
            similarity += (ranking_1['rating'].to_i-@extractor.user_movie_ranking[user_2+ranking_1['movie']].to_i)**2
          end
        end
        if common_items>0
          similarity = Math.sqrt(similarity/common_items)
          similarity = 1.0 - Math.tanh(similarity)
          max_common_items = [user_1_rankings.size, user_2_rankings.size].min
          similarity = similarity * (common_items.to_f/max_common_items.to_f)
        end
        @user_similarity_list[user_1+user_2] = similarity
      end
      puts "Number #{index} User #{user_1} similarity done"
    end
    puts "similarity generated"
  end
end

class MockExtractor
  attr_reader :rankings

  def initialize
    @rankings = {'Koopa'=>[{'movie'=>'Titanic', 'rating'=>4}, {'movie'=>'LOTR', 'rating'=>4}, {'movie'=>'Rambo', 'rating'=>3}], 'Mario'=>[{'movie'=>'Titanic', 'rating'=>4}, {'movie'=>'Braveheart', 'rating'=>5}, {'movie'=>'Rocky', 'rating'=>4}], 'Luigi'=>[{'movie'=>'Titanic', 'rating'=>4}, {'movie'=>'Braveheart', 'rating'=>5}, {'movie'=>'Harry Potter', 'rating'=>5}, {'movie'=>'LOTR', 'rating'=>5}]}
  end

  def extract_users
    ['Mario', 'Luigi', 'Koopa']
  end

  def extract_movies_with_rankings(user)
    @rankings[user]
  end

  def extract_movies
    ['Titanic', 'LOTR', 'Braveheart', 'Harry Potter']
  end
end

require_relative 'recommender'
require_relative 'movie_lens100k_extractor'
extractor = MovieLens100kExtractor.new
similarity = Similarity.new(extractor)
similarity.generate_similarities

recommender = Recommender.new(extractor, similarity.user_similarity_list)

recommendations = recommender.recommendations_for('115')

puts recommendations
