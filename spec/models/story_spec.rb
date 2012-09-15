require 'spec_helper'

describe Story do
  
  let(:story) { stub_model(Story) }

  describe "#likes_count" do

    it "should return the count of likes a story has" do
      story.stub_chain(:likes, :count) { 20 }
      story.likes_count.should == 20
    end

  end

end
