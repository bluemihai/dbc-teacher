require 'yaml'

class PhaseDay < ActiveRecord::Base
  YAML_FILE = File.open("#{Rails.root}/db/seeds/phase_days.yml", 'r')

  has_many :phase_lead_requests

  def self.load_from_yaml
    phases = YAML.load(YAML_FILE.read)
    phases.each do |phase, days|
      puts "phase is #{phase}"
      days.each do |day, title|
        "days is #{day}, title is #{title}"
        PhaseDay.create!(phase_no: phase.chars[-1].to_i, day_no: day, title: title)
      end
    end
  end
end
