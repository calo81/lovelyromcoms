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
