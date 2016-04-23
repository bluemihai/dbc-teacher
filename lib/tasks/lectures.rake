require 'yaml'

namespace :phase_days do
  desc "Load phasely lectures"
  task :load do
    PhaseDay.load_from_yaml
  end
end