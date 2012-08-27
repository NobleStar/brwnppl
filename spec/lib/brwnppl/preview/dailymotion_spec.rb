describe Brwnppl::Preview::Dailymotion do 

  let(:dailymotion_video) { "http://www.dailymotion.com/video/xrzk1p_assassin-s-creed-3-rise-trailer_videogames" }
  let(:dm_preview) { Brwnppl::Preview::Dailymotion.new }

  describe "#reconstruct_embed" do

    it "should extract the video id and construct an embed URL" do
      dm_preview.reconstruct_embed(dailymotion_video).should == 'http://dailymotion.com/embed/video/xrzk1p'
    end

  end

  describe "#html" do

    it "should generate the proper embed HTML" do
      graph_object = double()
      graph_object.stub(:url) { dailymotion_video }
      dm_preview.html(graph_object).should == "<iframe frameborder='0' width='480' height='270' src='http://dailymotion.com/embed/video/xrzk1p'></iframe>"
    end

  end

end