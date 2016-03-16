# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

locations = [['San Francisco', 'sf'], ['Chicago', 'chi'], ['New York', 'nyc']]
locations.each do |names|
  Location.create!(city: names[0], abbrev: names[1], status: 'active')
end

sf = Location.find_by(abbrev: 'sf')
raise "Could not find sf" if sf.nil?

sf_teachers = ['aespaldi', 'amgando', 'bluemihai', 'booneteam', 'b0uma', 'bootcoder', 'dreeve', 'jkarnowski', 'salogel42', 'ssachid', 'sebabelmar']
sf_teachers.each do |github|
  teacher = User.create_from_github(github, sf, 'admin')
  puts "Added teacher #{teacher.name} (#{teacher.github_login})"
end

sf_mentors = ['benvogcodes', 'bfaloona', 'jbomotti', 'neurodynamic', 'twymer']
sf_mentors.each do |github|
  mentor = User.create_from_github(github, sf, 'mentor')
  puts "Added mentor #{mentor.name} (#{mentor.github_login})"
end

sf_staff = ['lferrari2', 'CatMingHubbard']
sf_staff.each do |github|
  staff = User.create_from_github(github, sf, 'staff')
  puts "Added staff member #{staff.name} (#{staff.github_login})"
end

cohorts = {1 => 'sf-sea-lions-2016', 2 => 'sf-fiddler-crabs-2016', 3 => 'sf-squirrels-2016'}
cohorts.each do |phase, github|
  Cohort.create_and_populate(github, phase)
end