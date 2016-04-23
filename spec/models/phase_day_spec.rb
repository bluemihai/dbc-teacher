require 'rails_helper'

RSpec.describe PhaseDay, type: :model do
  before (:each) { @phase_day = FactoryGirl.create(:phase_day) }

  it "ph(id) scope should work" do
    5.times { FactoryGirl.create(:phase_day, phase_no: 7) }
    expect(PhaseDay.ph(7).length).to eq 5
  end
end
