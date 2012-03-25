require 'spec_helper'
describe "Inject Support" do

  it "should inject properties in my objects" do
    class AnyClass
      inject :recommender
    end
    a = AnyClass.new
    a.recommender.should_not be_nil
  end
end