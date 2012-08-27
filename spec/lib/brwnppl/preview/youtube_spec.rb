describe Brwnppl::Preview::Youtube do
  
  describe "#html" do
    let(:youtube_video) { "http://www.youtube.com/embed/y-h-EfaShoE" }

    it "should return the embed url html for a provided youtube url" do
      graph_object = double()
      graph_object.stub(:video) { youtube_video }
      Brwnppl::Preview::Youtube.new.html(graph_object).should == "<iframe width='530' height='300' src='http://www.youtube.com/embed/y-h-EfaShoE' frameborder='0' allowfullscreen></iframe>"
    end

  end

end