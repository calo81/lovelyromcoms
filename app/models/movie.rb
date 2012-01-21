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
    set_total_and_save(indicator)
  end

  def set_indicators_for_user(user, indicators)
    self["indicators"] ||= {}
    indicators.each do |indicator_name, indicator_value|
      self.indicators[indicator_name] ||= {}
      self.indicators[indicator_name]["reviewers"] ||= []
      replace_or_set_indicator(indicator_name, indicator_value, user)
      set_total_and_save(indicator_name)
    end
  end

  private

  def replace_or_set_indicator(indicator_name, indicator_value, user)
    self.indicators[indicator_name]["reviewers"].delete_if { |reviewer| reviewer["id"]==user.id }
    self.indicators[indicator_name]["reviewers"]<<{"id"=>user.id, "value"=>indicator_value.to_i}
  end

  def set_total_and_save(indicator)
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