require 'rails_helper'

RSpec.describe Cohort, type: :model do

  before(:each) { @cohort = FactoryGirl.create(:cohort) }

  subject { @cohort }

  it { should respond_to(:name) }
  
  it "Cohort#create_and_populate works" do
    expect(Cohort.count).to eq(1)
    expect(User.count).to eq(0)
    Cohort.create_and_populate('sf-sea-lions-2016')
    expect(Cohort.count).to eq(2)
    expect(User.count).to be > 10
  end

end
