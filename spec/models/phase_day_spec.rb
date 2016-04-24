require 'rails_helper'

RSpec.describe PhaseDay, type: :model do
  before (:each) { @phase_day = FactoryGirl.create(:phase_day) }

  it "ph(id) scope should work" do
    5.times { FactoryGirl.create(:phase_day, phase_no: 7) }
    expect(PhaseDay.ph(7).length).to eq 5
  end

  it '#potential_dates should work' do
    puts "@phase_day is #{@phase_day.inspect}"
    expect(@phase_day.potential_dates).to include Date.new(2016, 4, 11)
  end

end
