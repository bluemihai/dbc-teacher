class PhaseLeadRequest < ActiveRecord::Base
  belongs_to :phase_day
  belongs_to :teacher, class_name: 'User'

  validates_uniqueness_of :phase_day_id, scope: [:teacher_id, :day]

  def accepted?
    return approved_by_coordinator unless approved_by_coordinator.nil?
    all_requests = self.class.find_by(
      phase_no: phase_no, day_no: day_no, location: location)
  end

  def self.create_from_teacher_short!(args)
    teacher = User.find_by(short: args[:teacher])
    puts "teacher is #{teacher}"
    day_no = (args[:week] - 1) * 5 + args[:day]
    phase_day = PhaseDay.find_by({
      phase_no: args[:phase],
      day_no: day_no
    })
    puts "phase_day is #{phase_day}"
    return false unless teacher && phase_day
    self.create!(teacher: teacher, day: args[:mon], phase_day: phase_day)
    true
  end

  def self.load_phase_leads_from_arrays(args)
    arrays = args[:arrays]
    arrays.in_groups_of(3).each_with_index do |week, week_index|
      phase.each_with_index do |phase, phase_index|
        phase.each_with_index do |teacher_short, day_index|
          self.create_from_teacher_short_and_mon(teacher_short, args[:mon])
        end
      end
    end
  end
end