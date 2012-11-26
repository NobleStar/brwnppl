json.array!(@stories) do |json, story|
  
  json.partial! "story", story: story

  json.comments story.comments do |json, comment|
    json.partial! "comment", comment: comment
  end

end