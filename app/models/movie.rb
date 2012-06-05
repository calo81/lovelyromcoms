class Movie
  include MongoMapper::Document

  def self.find_movie_of_the_day
    all[Random.rand(all.count)]
  end

  def self.retrieve_sorted_by(field, sorti=:asc, elements=10, page=1)
    sort = sorti == :desc ? :desc : :asc
    movies = self.paginate({
                               :order => [[field, sort]],
                               :per_page => elements,
                               :page => page,
                           })
    movies.each_with_index do |movie, index|
      movies[index]= self.find(movie.id)
    end
  end

  def indicator_for_user(indicator, user)
    return "" unless indicators[indicator]
    self.indicators[indicator]["reviewers"].each do |reviewer|
      if reviewer["id"]==user.id
        return reviewer["value"]
      end
    end
    return ""
  end


  def set_indicator_for_user(user, indicator, value)
    replace_or_set_indicator(indicator, value, user)
    set_total_for_indicator(indicator)
  end

  def set_indicators_for_user(user, indicators)
    self["indicators"] ||= {}
    indicators.each do |indicator_name, indicator_value|
      next if indicator_value.to_i == 0
      self.indicators[indicator_name] ||= {}
      self.indicators[indicator_name]["reviewers"] ||= []
      replace_or_set_indicator(indicator_name, indicator_value, user)
      set_total_for_indicator(indicator_name)
    end
  end

  def avg_score
    if !self["indicators"] or self["indicators"].empty?
      return 0
    end
    total = 0.0
    count = 0.0
    self["indicators"].each do |indicator, value|
      total += value["total"]
      count += 1
    end
    total_double = total / count
    (total_double*100).to_i / 100.0
  end

  def synopsis_if_existent
    begin
      return synopsis
    rescue
      return ""
    end
  end

  def trailer_if_existent
    begin
      return trailer
    rescue
      return ""
    end
  end

  def reviews_if_existent
    return self["reviews"] ? self["reviews"] : []
  end

  def set_review_for_user(user, review)
    self["reviews"] ||= []
    self["reviews"].delete_if do |review|
      review["user_id"]==user.id
    end
    self["reviews"] << {"user_id"=>user.id, "review"=>review}
  end

  def review_for_user(user)
    self["reviews"] ||= []
    self["reviews"].each do |review|
      if review["user_id"]==user.id
        return review["review"]
      end
    end
    return ""
  end

  def self.top_by_critics_rating(how_many)
    retrieve_sorted_by('ratings.critics_score',:desc,how_many)
  end

  private

  def replace_or_set_indicator(indicator_name, indicator_value, user)
    self.indicators[indicator_name]["reviewers"].delete_if { |reviewer| reviewer["id"]==user.id }
    self.indicators[indicator_name]["reviewers"]<<{"id"=>user.id, "value"=>indicator_value.to_i}
  end

  def set_total_for_indicator(indicator)
    total = 0
    elements = 0
    self.indicators[indicator]["reviewers"].each do |reviewer|
      total += reviewer["value"]
      elements += 1
    end
    self.indicators[indicator]["total"]=(total.to_f/elements.to_f).to_f
    self.save!
  end
end