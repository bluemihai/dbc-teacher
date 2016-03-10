json.array!(@interactions) do |interaction|
  json.extract! interaction, :id, :student_id, :teacher_id, :minutes, :topic, :challenge_id, :rating, :learned
  json.url interaction_url(interaction, format: :json)
end
