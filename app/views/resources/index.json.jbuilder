json.array!(@resources) do |resource|
  json.extract! resource, :id, :url, :phase_day_id, :source, :last_shared, :usefulness_rating
  json.url resource_url(resource, format: :json)
end
