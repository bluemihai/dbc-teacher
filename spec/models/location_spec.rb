require 'rails_helper'

RSpec.describe Location, type: :model do

  before(:each) { @location = FactoryGirl.create(:location) }

  subject { @location }
  
  it { should respond_to :city }
  it { should respond_to :abbrev }
  it { should respond_to :status }

end
