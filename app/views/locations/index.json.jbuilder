json.array!(@locations) do |location|
  json.extract! location, :id, :city, :abbrev, :status
  json.url location_url(location, format: :json)
end
