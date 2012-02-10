require 'spec_helper'
require File.expand_path("../../../lib/searcher", __FILE__)
describe 'Searcher should search' do
  before(:each) do
    movie1 = Movie.new(:id=>"123123", :title=>"Easy A", :synopsys=>"Una historia agradable", :abridged_cast=>[{"name"=>"Emma Algo"}, {"name"=>"John Wayne"}], :posters=>{"profile"=>"http://ccc"})
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
    result[0]["actor"].should ==["Emma Algo", "John Wayne"]
    result[0]["matched_by"].should == :title
  end

  it "Should find correct movies when called for actor" do
    result = MovieSearcher.search("Way*")
    result.size.should == 1
    result[0]["title"].should == "Easy A"
    result[0]["id"].should == "123123"
    result[0]["actor"].should ==["Emma Algo", "John Wayne"]
    result[0]["image_url"][0].should == "http://ccc"
    result[0]["matched_by"].should == :actor
  end
end