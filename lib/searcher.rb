class MovieSearcher
  @solr = RSolr.connect :url => 'http://localhost:8983/solr/collection1/'

  def self.search(term)
    term = term.downcase
    response = @solr.get 'select', :params => {:q => "title:#{term}*"}
    list = response["response"]["docs"]
    list
  end
end