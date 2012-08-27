describe Brwnppl::Preview::Vimeo do
  let(:vimeo_url)     { "http://vimeo.com/48236494" }
  let(:graph_object)  { double() }
  let(:vimeo_preview) { Brwnppl::Preview::Vimeo.new }

  describe "#html" do

    it "should generate embeddable HTML" do
      graph_object.stub(:url) { vimeo_url }
      vimeo_preview.html(graph_object).should == "<iframe src='http://player.vimeo.com/video/48236494' width='500' height='281' frameborder='0' webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>"
    end

  end


  describe "#reconstruct_embed" do

    it "should reconstruct the embed URL" do
      vimeo_preview.reconstruct_embed(vimeo_url).should == 'http://player.vimeo.com/video/48236494'
    end

  end

end