  class Cohort < ActiveRecord::Base
  belongs_to :location
  has_many :members, class_name: 'User'

  default_scope { order(:phase_1_start).reverse }

  def self.active
    select{ |c| c.phase < 4 && c.phase > 0}.sort_by(&:phase)
  end

  def phase
    today = Time.zone.now.to_date
    return 0 if phase_1_start > today
    return 1 if phase_1_start > 3.weeks.ago
    return 2 if phase_1_start > 6.weeks.ago
    return 3 if phase_1_start > 9.weeks.ago
    return 4 if phase_1_start > 12.weeks.ago
    return 5
  end
  
  def phase_cohort
    "#{phase.to_s}-#{name.to_s}"
  end

  def auto_github_name
    "#{location.abbrev.downcase}-#{name_hyphenize_downcase}-#{phase_1_start.year.to_s}"
  end

  def github_team_url
    "http://github.com/#{auto_github_name}"
  end

  def name_hyphenize_downcase
    name.downcase.split(' ').join('-')
  end

  # returns an array of GitHub info hashes
  def members_from_github
    raise 'No ENV["GITHUB_PERSONAL_ACCESS_TOKEN"]' unless ENV["GITHUB_PERSONAL_ACCESS_TOKEN"]
    "Running members_from_github"
    JSON.parse eat("https://api.github.com/orgs/#{github_name}/members?access_token=" + ENV["GITHUB_PERSONAL_ACCESS_TOKEN"])
  end

  def self.create_and_populate(github_handle, phase, year=2016, month=1, day=1, github_hashes_mock=nil)
    parts = github_handle.split('-')
    city_abbrev = parts.shift
    loc = Location.find_by(abbrev: city_abbrev)
    if loc.nil?
      raise "Could not find a location with city_abbrev #{city_abbrev}.  Try creating that first."
    end
    parts.pop  # get rid of the 2016, we're not using it
    name = parts.join(' ').titleize
    c = Cohort.create(github_name: github_handle, location: loc, name: name, current_phase: phase, phase_1_start: Date.new(year, month, day))
    c.populate(github_hashes_mock)
  end

  def populate(github_hashes_mock=nil)
    github_hashes_mock ||= members_from_github
    github_hashes_mock.each do |h|
      u = User.create_from_github(h['login'])
      if u
        puts "Created student #{u.name} (github #{u.github_login}, cohort #{u.cohort.try(:github_name)})"
        u.update(cohort: self)
      end
    end
    return self
  end
end


["jbomotti",
 "jkarnowski",
 "katymartin16",
 "KyleRombach",
 "liajames",
 "mikelikesbikes",
 "mikelondon",
 "PhilB-1"]
 