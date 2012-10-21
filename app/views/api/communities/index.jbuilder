json.array!(@communities) do |json, community|
  
  json.id       community.id
  json.name     community.name
  json.slug     community.slug
  
end