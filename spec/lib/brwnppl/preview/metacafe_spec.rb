describe Brwnppl::Preview::Metacafe do

  let(:metacafe_url) { "http://www.metacafe.com/watch/8630515/meeting_evil_movie_trailer/" }
  let(:mc_preview)   { Brwnppl::Preview::Metacafe.new }
  
  describe "#html" do

    it "should return the complete html embed iframe" do
      graph_object = double()
      graph_object.stub(:url) { metacafe_url }
      mc_preview.html(graph_object).should == "<embed flashVars='playerVars=autoPlay=no' src='http://metacafe.com/fplayer/8630515/meeting_evil_movie_trailer.swf' width='530' height='300' wmode='transparent' allowFullScreen='true' allowScriptAccess='always' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash'></embed>" 
    end

  end

  describe "#reconstruct_embed" do

    it "should construct the embed url for the given metacafe url" do
      mc_preview.reconstruct_embed(metacafe_url).should == 'http://metacafe.com/fplayer/8630515/meeting_evil_movie_trailer.swf'
    end

  end

end