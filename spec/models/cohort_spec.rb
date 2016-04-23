require 'rails_helper'

RSpec.describe Cohort, type: :model do

  before(:each) do
    @la = FactoryGirl.create(:location, abbrev: 'la')
    @cohort = FactoryGirl.create(:cohort, location: @la)
  end

  subject { @cohort }

  it { should respond_to(:name) }

  it '#phase should work' do
    
  end
  
  it "Cohort#create_and_populate should work" do
    expect(Cohort.count).to eq(1)
    expect(User.count).to eq(0)
    hashes = [
      {'login' => 'afayek1'}, 
      {'login' => 'alfredlam42'},
      {'login' => 'amblount'},
      {'login' => 'andriayr'},
    ]
    puts "Location.find_by(abbrev: 'la') is #{Location.find_by(abbrev: 'la')}"

    c = Cohort.create_and_populate('la-grass-hoppers-2016', 5, 2016, 2, 29, hashes)

    expect(Cohort.count).to eq(2)
    expect(c.location.abbrev).to match 'la'
    expect(c.phase_1_start).to eq(Date.new(2016, 2, 29))
    expect(c.current_phase).to eq(5)
    expect(c.name).to match 'Grass Hoppers'  
    expect(User.count).to eq(4)

    expect(c.members.first.cohort).to eq(c)
  end

end
