class PhaseLeadRequest < ActiveRecord::Base
  belongs_to :phase_day
  belongs_to :teacher, class_name: 'User'

  def accepted?
    return approved_by_coordinator unless approved_by_coordinator.nil?
    all_requests = self.class.find_by(phase_no: phase_no, day_no: day_no, location: location)
  end
end
