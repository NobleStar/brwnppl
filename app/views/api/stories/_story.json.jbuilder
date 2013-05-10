json.id             story.id
json.image          story.image.present? ? story.image : "http://brwnppl.com/assets/default-story-image.png"
json.slug           story.slug
json.title          story.title
json.url            story.url
json.user_id        story.user_id
json.likes_count    story.likes_count
json.comments_count story.comments_count
json.posted_ago     time_ago_in_words(story.created_at)
json.user           story.user, :id, :name, :avatar, :username
json.content_type   story.content_type
json.brownie_points story.brownie_points
json.reshare_count  story.reshare_count
json.magnific_type  story.magnific_type