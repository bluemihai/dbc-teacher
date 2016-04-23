json.array!(@phase_lead_requests) do |phase_lead_request|
  json.extract! phase_lead_request, :id, :day, :teacher_id, :phase_day_id, :approved_by_coordinator
  json.url phase_lead_request_url(phase_lead_request, format: :json)
end
