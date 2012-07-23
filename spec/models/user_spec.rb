require 'spec_helper'

describe User do
  
  it { should have_many(:authentications).dependent(:destroy) }
  it { should have_many(:stories) }

  describe "#update_avatar" do
    let(:user)         { stub_model(User, username: 'someuser', save: true ) }
    let(:fb_user_hash) { {:user_info => { :id => '123456' }} }
    let(:tw_user_hash) { {:user_info => { :profile_image_url => 'http://example.com/someimage.png' }} }

    it "should update the Facebook avatar on every login" do
      user.update_avatar('facebook', fb_user_hash).avatar.should == 'http://graph.facebook.com/123456/picture'
    end

    it "should update the Twitter avatar on every login" do
      Twitter.stub_chain(:user, :profile_image_url).and_return('http://example.com/someimage.png')
      user.update_avatar('twitter', tw_user_hash).avatar.should == 'http://example.com/someimage.png'
    end

  end

end
