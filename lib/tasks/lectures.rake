require 'yaml'

namespace :lectures do
  desc "Load phasely lectures"
  task :load do
    puts "Rails root is: #{Rails.root}"
    filename = "#{Rails.root}/config/lectures.yml"
    puts "filename is #{filename}"
    lectures = open(filename, 'r').read
    puts "lectures is #{lectures}"
    puts YAML.load(lectures)
  end
end