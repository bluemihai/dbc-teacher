require 'rails_helper'

RSpec.describe Interaction, type: :model do

  before(:each) do
    @student = FactoryGirl.create(:user, role: 'student')
    @teacher = FactoryGirl.create(:user, role: 'teacher')
    @interaction = FactoryGirl.create(:interaction, student: @student, teacher: @teacher, minutes: 15, topic: 'Hash syntax', rating: 2)
  end

  subject { @interaction }

  it { should respond_to(:minutes) }

end
