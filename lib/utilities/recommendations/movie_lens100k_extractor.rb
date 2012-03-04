class MovieLens100kExtractor
  attr_reader :rankings
  attr_reader :user_movie_ranking

  def initialize
    @rankings = {}
    @user_movie_ranking ={}
    File.open('../../../vendor/movierecomendations/ml-100k/u.data', 'r') do |f|
      f.each_line do |line|
        values = line.split(" ")
        @rankings[values[0]] ||= []
        @rankings[values[0]] << {'movie'=>values[1], 'rating'=>values[2]}
        @user_movie_ranking[values[0]+values[1]]=values[2]
      end
    end
  end

  def extract_users
    @users ||= []
    return @users if !@users.empty?
    File.open('../../../vendor/movierecomendations/ml-100k/u.data', 'r') do |f|
      f.each_line do |line|
        user = line.split(" ")[0]
        if !@users.include? user
          @users << line.split(" ")[0]
        end
      end
    end
    @users
  end

  def extract_movies_with_rankings(user)
    @rankings[user]
  end

  def extract_movies
    @movies ||= []
    return @movies if !@movies.empty?
    File.open('../../../vendor/movierecomendations/ml-100k/u.data', 'r') do |f|
      f.each_line do |line|
        movie = line.split(" ")[1]
        if !@movies.include? movie
          @movies << line.split(" ")[1]
        end
      end
    end
    @movies
  end
end