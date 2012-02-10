class MovieSearcher
  @solr = RSolr.connect :url => 'http://localhost:8983/solr/collection1/'

  def self.search(term)
    term = term.downcase
    response = @solr.get 'select', :params => {:q => "title:#{term}*"}
    list = response["response"]["docs"]
    list.each{|movie| movie["matched_by"] = :title}
    response = @solr.get 'select', :params => {:q => "actor:#{term}*"}
    list2 = response["response"]["docs"]
    list2.each{|movie| movie["matched_by"] = :actor}
    list.concat(list2)
    list
  end
end