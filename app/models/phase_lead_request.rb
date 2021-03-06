class PhaseLeadRequest < ActiveRecord::Base
  FROM = Date.new(2016, 2, 29)
  UNTIL = Date.new(2016, 5, 22)

  belongs_to :phase_day
  belongs_to :teacher, class_name: 'User'

  validates :day, presence: true

  enum role: ['Float', 'Lead 1', 'Lead 2', 'Lead 3', 'PDG', 'Off']

  default_scope { order(:day) }
  scope :by_day, ->(day) { where(day: day) }
  scope :in_range, ->(starting, ending) { where(day: starting..ending)}

  validates_uniqueness_of :phase_day_id, scope: [:teacher_id, :day]

  def self.data_for_mon(mon)
    in_range(mon, mon + 21.days).group_by_recursive(:week, :phase, :day_no)
  end

  def self.potential_days(day_no)
    POTENTIAL_STARTS.map{ |d| d + (day_no + 1).days }
  end

  def self.data_grid(requests)
    calendar = (FROM..UNTIL).to_a.in_groups_of(7)
    calendar.map do |week|
      week.delete_at(5)
      week.delete_at(6)
      week.each_with_index do |day, idx|
        week[idx] = [day, requests.select{ |r| r.day == day}]
      end
      week.to_h
    end
    calendar
  end

  def day_no
    phase_day.day_no
  end

  def week
    phase_day.week_no
  end

  def phase
    phase_day.phase_no
  end

  def who_what
    "#{self.teacher.short} — #{self.phase_day.title}"
  end

  def accepted?
    return approved_by_coordinator unless approved_by_coordinator.nil?
    all_requests = self.class.find_by(
      phase_no: phase_no, day_no: day_no, location: location)
  end

  def self.create_from_teacher_short!(args)
    teacher = User.find_by(short: args[:teacher_short])
    day_no = (args[:week] - 1) * 5 + args[:day]
    phase_day = PhaseDay.find_by({
      phase_no: args[:phase],
      day_no: day_no
    })
    return false if teacher.nil? || phase_day.nil?
    self.create!({
      teacher: teacher,
      day: args[:mon] + (day_no - 1).days,
      phase_day: phase_day,
    })
    true
  end

  def self.load_phase_leads_from_arrays(args)
    arrays = args[:arrays]
    arrays.in_groups_of(3).each_with_index do |week, week_index|
      week.each_with_index do |phase, phase_index|
        phase.each_with_index do |teacher_short, day_index|
          day = args[:mon] + (day_index + 1).days
          self.create_from_teacher_short!({
            teacher_short: teacher_short,
            week: week_index + 1,
            day: day_index + 1,
            phase: phase_index + 1,
            mon: args[:mon]
          })
        end
      end
    end
  end
end