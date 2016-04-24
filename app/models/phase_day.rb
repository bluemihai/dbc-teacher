require 'yaml'

class PhaseDay < ActiveRecord::Base
  YAML_FILE = File.open("#{Rails.root}/db/seeds/phase_days.yml", 'r')
  has_many :phase_lead_requests

  scope :ph, ->(id) { where(phase_no: id) }

  def name
    phase_week_weekday_title
  end

  def phase_week_weekday_title
    "Phase #{phase_no}, Week #{week_no}, #{weekday} — #{title}"
  end

  def week_no
    (day_no - 1) / 5 + 1
  end

  def weekday
    weekdays = {1 => 'Mon', 2 => 'Tue', 3 => 'Wed', 4 => 'Thu', 0 => 'Fri'}
    weekdays[day_no % 5]
  end

  def potential_dates
    (0..360).step(21).map { |x| Date.new(2016, 1, 18) + x.days }
  end

  def self.load_from_yaml
    phases = YAML.load(YAML_FILE.read)
    phases.each do |phase, days|
      puts "phase is #{phase}"
      days.each do |day, title|
        "days is #{day}, title is #{title}"
        PhaseDay.create!(
          phase_no: phase.chars[-1].to_i,
          day_no: day,
          title: title
        )
      end
    end
  end
end
