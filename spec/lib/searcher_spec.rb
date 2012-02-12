require 'spec_helper'
require File.expand_path("../../../lib/searcher", __FILE__)
describe 'Searcher should search' do
  before(:each) do
    movie1 = Movie.new(:id=>"123123", :title=>"Easy A", :synopsys=>"Una historia agradable", :abridged_cast=>[{"name"=>"Emma Algo","image"=>"http://1url"}, {"name"=>"John Wayne","image"=>"http://2url"}], :posters=>{"profile"=>"http://ccc"})
    movie2 = Movie.new(:id=>"99999", :title=>"Die Hard", :synopsys=>"Muelte al hampa", :abridged_cast=>[{"name"=>"Bruce Willis"}, {"name"=>"Alan Rickman"}], :posters=>{"profile"=>"http://xxx"})
    indexer = Indexer.new
    indexer.index [movie1, movie2]
    #wait for index to commit.
    sleep(1)
  end

  it "Should find correct movies when called for title" do
    result = MovieSearcher.search("Eas*")
    result.size.should == 1
    result[0]["title"].should == "Easy A"
    result[0]["id"].should == "123123"
    result[0]["poster_url"].should == "http://ccc"
  end
end
