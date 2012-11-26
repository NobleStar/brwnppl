json.id             story.id
json.image          story.image
json.slug           story.slug
json.title          story.title
json.url            story.url
json.user_id        story.user_id
json.likes_count    story.likes_count
json.comments_count story.comments_count
json.posted_ago     time_ago_in_words(story.created_at)
json.user           story.user, :id, :name, :avatar, :username