json.array!(@phase_days) do |phase_day|
  json.extract! phase_day, :id, :title, :phase_no, :day_no, :lead_required
  json.url phase_day_url(phase_day, format: :json)
end
