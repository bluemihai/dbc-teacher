require 'rails_helper'

RSpec.describe PhaseDay, type: :model do
  before (:each) { @phase_day = FactoryGirl.create(:phase_day) }

  it "ph(id) scope should work" do
    5.times { FactoryGirl.create(:phase_day, phase_no: 7) }
    expect(PhaseDay.ph(7).length).to eq 5
  end

  it '#potential_dates should work' do
    expect(PhaseDay::POTENTIAL_DATES).to include Date.new(2016, 4, 11)
  end

  it 'PhaseDay#load_from_yaml should work' do
    expect(PhaseDay.load_from_yaml.keys).to eq ['phase_1', 'phase_2', 'phase_3']
  end

end
