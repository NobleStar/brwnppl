json.array!(@stories) do |json, story|
  json.partial! "story", story: story
  json.next_page  @stories.last_page? ? nil : @stories.current_page + 1
  json.previous_page @stories.first_page? ? nil: @stories.current_page - 1
end