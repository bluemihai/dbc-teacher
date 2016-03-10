class Cohort < ActiveRecord::Base
  belongs_to :location
  
  def auto_github_name
    "#{location.abbrev.downcase}-#{name_hyphenize_downcase}-#{phase_1_start.year.to_s}"
  end

  def github_team_url
    "http://github.com/#{auto_github_name}"
  end

  def name_hyphenize_downcase
    name.downcase.split(' ').join('-')
  end
end
