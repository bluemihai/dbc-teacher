json.array!(@cohorts) do |cohort|
  json.extract! cohort, :id, :name, :github_name, :phase_1_start, :location_id
  json.url cohort_url(cohort, format: :json)
end
