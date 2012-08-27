describe Brwnppl::Preview::Soundcloud do
  
  let(:soundcloud_link) { "http://soundcloud.com/neeraj_laddi/jay-sean-i-don-t-know" }
  let(:graph_object)    { double() }
  let(:sc_preview)      { Brwnppl::Preview::Soundcloud.new }
  
  describe "#html" do

    it "should generate the embeddable HTML" do
      graph_object.stub(:video) { "http://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F57432607&show_artwork=true" }
      sc_preview.html(graph_object).should == "<iframe width='530' height='80' scrolling='no' frameborder='no' src='http://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F57432607&show_artwork=true'></iframe>"
    end
  end

end