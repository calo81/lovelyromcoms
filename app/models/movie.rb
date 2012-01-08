class Movie
  include MongoMapper::Document

  def self.find_movie_of_the_day
    all[Random.rand(all.count)]
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
    self.indicators[indicator]["reviewers"]<<{"id"=>user.id, "value"=>value}
    total = 0
    self.indicators[indicator]["reviewers"].each do |reviewer|
      total += reviewer["value"]
    end
    self.indicators[indicator]["total"]=total
    self.save!
  end

  def set_indicators_for_user(user,indicators)
    self["indicators"] ||= {}
    indicators.each do |indicator_name,indicator_value|
       self.indicators[indicator_name] ||= {}
       self.indicators[indicator_name]["reviewers"] ||= []
       self.indicators[indicator_name]["reviewers"]<<{"id"=>user.id, "value"=>indicator_value.to_i}
       total = 0
       self.indicators[indicator_name]["reviewers"].each do |reviewer|
         total += reviewer["value"]
       end
        self.indicators[indicator_name]["total"]=total
     end
    self.save!
  end
end