  class Cohort < ActiveRecord::Base
  belongs_to :location
  has_many :members, class_name: 'User'
  
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
    JSON.parse eat("https://api.github.com/orgs/#{github_name}/members?access_token=" + ENV["GITHUB_PERSONAL_ACCESS_TOKEN"])
  end

  def self.create_and_populate(github_handle, phase, year=2016, month=1, day=1, github_hashes=nil)
    parts = github_handle.split('-')
    city_abbrev = parts.shift
    loc = Location.find_by(abbrev: city_abbrev)
    if loc.nil?
      raise "Could not find a location with city_abbrev #{city_abbrev}.  Try creating that first."
    end
    parts.pop  # get rid of the 2016, we're not using it
    name = parts.join(' ').titleize
    c = Cohort.create(github_name: github_handle, location: loc, name: name, current_phase: phase, phase_1_start: Date.new(year, month, day))
    c.populate(loc, github_hashes)
  end

  def populate(location, github_hashes=nil)
    github_hashes ||= members_from_github
    github_hashes.each do |h|
      u = User.create_from_github(h['login'], location)
      if u
        puts "Created student #{u.name} (github #{u.github_login}, cohort #{u.cohort.try(:github_name)})"
        u.update(cohort: self)
      end
    end
    return self
  end
end
