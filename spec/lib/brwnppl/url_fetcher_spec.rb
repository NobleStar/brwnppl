describe Brwnppl::UrlFetcher do
  let(:url) { 'http://example.com' }
  let(:url_fetcher) { Brwnppl::UrlFetcher.new(url) }

  before(:each) do
    OpenGraph.stub(:fetch).and_return(OpenGraph::Object.new({ :title => 'Example', :url => 'http://example.com', :site_name => 'YouTube'}))
  end
	
  describe "#initialize" do
    
    it "should raise error if initialized without url" do
      expect { Brwnppl::UrlFetcher.new }.to raise_error
    end

    it "should return an html element in the hash if the url contains OGP data" do
      url_fetcher.stub(:open_graph_url?) { OpenGraph::Object.new }
      url_fetcher.instance_variable_get("@story_data").should be_an_instance_of(OpenGraph::Object)
    end

    it "should return an OpenGraph::Object like object otherwise" do
      OpenGraph.stub(:fetch) { false }
    end

  end

  describe "#open_graph_url?" do

    it "should set @story_data instance_var if url confirms to OG protocol" do
      url_fetcher.open_graph_url?.should_not be_false
      url_fetcher.open_graph_url?.should be_an_instance_of(OpenGraph::Object)
    end

    it "should return false if url is not OG url" do
      OpenGraph.stub(:fetch) { false }
      url_fetcher.open_graph_url?.should be_false
    end
    
  end

end