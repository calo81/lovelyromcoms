class FileRatingsExtractor
  attr_reader :rankings
  attr_reader :user_movie_ranking

  def initialize(file_location)
    @file_location=file_location
    @rankings = {}
    @user_movie_ranking ={}
    @users ||= {}
    @movies ||= {}
    File.open(@file_location, 'r') do |f|
      f.each_line do |line|
        values = line.split("|")
        @rankings[values[0]] ||= []
        @rankings[values[0]] << {'movie'=>values[1], 'rating'=>values[2]}
        @user_movie_ranking[values[0]+"MM"+values[1]]=values[2]
        extract_user_for_line line
        extract_movie_for_line line
      end
    end
    @users_list = @users.map  {|key,value| key}
    @movies_list = @movies.map  {|key,value| key}
  end

  def extract_users
    @users_list
  end

  def extract_movies_with_rankings(user)
    @rankings[user]
  end

  def extract_movies
    @movies_list
  end

  private
    def extract_user_for_line(line)
    user = line.split("|")[0]
    if !@users[user]
      @users[user]=true
    end
  end

  def extract_movie_for_line(line)
    movie = line.split("|")[1]
    if !@movies[movie]
      @movies[movie]=true
    end
  end
end