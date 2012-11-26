json.partial! "story", story: @story

json.comments @story.comments do |json, comment|
  json.partial! "comment", comment: comment
end