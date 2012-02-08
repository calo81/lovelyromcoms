require 'rsolr'
solr = RSolr.connect :url => 'http://localhost:8983/solr/collection1/'
#solr.add :title=>"Die Hard", :id=>2, :actor=>["Bruce Willis", "Alan Rickman"], :synopsys => "perfect movie"
#solr.add :title=>"17 Again", :id=>1, :synopsys=>"The old guy turning young", :actor=>["Chandler","Bruce Almighty"]

#solr.update :data => '<commit/>'

response = solr.get 'select', :params => {:q => 'actor:almig*'}

puts response