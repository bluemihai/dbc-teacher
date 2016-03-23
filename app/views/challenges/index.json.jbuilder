json.array!(@challenges) do |challenge|
  json.extract! challenge, :id, :name, :phase, :week, :github_repo, :description
  json.url challenge_url(challenge, format: :json)
end
