FactoryGirl.define do
  factory :phase_lead_request do
    day "2016-04-23"
    teacher_id 1
    phase_day_id 1
    approved_by_coordinator false
  end
end
