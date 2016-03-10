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
    JSON.parse eat("https://api.github.com/orgs/#{auto_github_name}/members?access_token=" + ENV["GITHUB_PERSONAL_ACCESS_TOKEN"])
  end

  def self.create_and_populate(github_name)
    parts = github_name.split('-')
    raise
  end
end
