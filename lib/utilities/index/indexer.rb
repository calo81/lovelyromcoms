require 'rsolr'
#response = solr.get 'select', :params => {:q => 'actor:almig*'}
class Indexer
  def initialize
    @solr = RSolr.connect :url => 'http://localhost:8983/solr/collection1/'
  end

  def index(movies)
    movies.each do |movie|
      actors = movie.abridged_cast.map{|actor| actor["name"]}
      @solr.add :id=>movie.id.to_s, :title=>movie.title, :actor=>actors, :image_url => [movie.posters["profile"]]
    end
    @solr.update :data => '<commit/>'
  end
end
