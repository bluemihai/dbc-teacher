require 'rails_helper'

RSpec.describe Cohort, type: :model do

  before(:each) do
    @la = FactoryGirl.create(:location, abbrev: 'LA')
    @cohort = FactoryGirl.create(:cohort, location: @la)
  end

  subject { @cohort }

  it { should respond_to(:name) }
  
  it "Cohort#create_and_populate should work" do
    expect(Cohort.count).to eq(1)
    expect(User.count).to eq(0)
    hashes = [
      {'login' => 'afayek1'}, 
      {'login' => 'alfredlam42'},
      {'login' => 'amblount'},
      {'login' => 'amgando'},
      {'login' => 'andriayr'},
      {'login' => 'benvogcodes'},
    ]
    c = Cohort.create_and_populate('la-grass-hoppers-2016', 2016, 2, 29, hashes)
    expect(Cohort.count).to eq(2)
    expect(c.location.abbrev).to match 'LA'
    expect(c.phase_1_start).to eq(Date.new(2016, 2, 29))
    expect(c.name).to match 'Grass Hoppers'  
    expect(User.count).to eq(6)
  end

end
