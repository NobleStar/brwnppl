json.content     comment.content
json.created_at  comment.created_at
json.id          comment.id
json.story_id    comment.story_id
json.updated_at  comment.updated_at
json.user_id     comment.user_id
# json.avatar      comment.avatar
# json.name        comment.name
# json.username    comment.user.username
json.timestamp   "posted #{time_ago_in_words(comment.created_at)} ago"