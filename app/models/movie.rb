class Movie
  include MongoMapper::Document
  def self.find_movie_of_the_day
    all[Random.rand(all.count)]
  end

  def indicator_for_user(indicator,user)
    return "" unless indicators[indicator]
    self.indicators[indicator]["reviewers"].each do |reviewer|
      if reviewer["id"]==user.id
        return reviewer["value"]
      end
    end
    return ""
  end
end