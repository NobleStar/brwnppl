json.avatar     user_avatar(@user)
json.email      @user.email
json.id         @user.id
json.name       @user.name
json.state      @user.state
json.username   @user.username
json.bio		@user.bio
json.stories(@user.recent_stories) do |json, story|
	json.partial! "api/stories/story", story: story
end
json.follower_count @user.followers.size
json.following_count @user.followed_users.size