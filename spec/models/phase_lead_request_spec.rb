require 'rails_helper'

RSpec.describe PhaseLeadRequest, type: :model do
  before(:each) do
    @larry = FactoryGirl.create(:user, short: 'Larry', role: 'teacher')
    @curly = FactoryGirl.create(:user, short: 'Curly', role: 'teacher')
    @moe = FactoryGirl.create(:user, short: 'Moe', role: 'teacher')
    @mon411 = Date.new(2016, 4, 11)
    @arrays = [
      ['Larry'] * 5,
      ['Larry'] * 5,
      ['Larry'] * 5,
      ['Larry', 'Curly', 'Moe', 'Curly', 'Moe'],
      ['Larry'] * 5,
      ['Larry'] * 5,
      ['Larry'] * 5,
      ['Larry'] * 5,
      ['Larry'] * 5
    ]

  end

  it 'self#data_for_mon works' do
  end

  it 'self#create_from_teacher_short' do
    PhaseDay.load_from_yaml
    expect(PhaseDay.count).to eq 45
    args = {teacher_short: 'Larry', mon: @mon411, week: 2, day: 4, phase: 3}
    expect(PhaseLeadRequest.create_from_teacher_short!(args)).to be true
    expect(PhaseLeadRequest.first.teacher).to eq @larry
    expect(PhaseLeadRequest.first.phase_day.day_no).to eq 9
  end

  it 'self#load_phase_leads_from_arrays works' do
    PhaseDay.load_from_yaml
    mon = Date.new(2016, 4, 11)
    args = {mon: mon, arrays: @arrays, approved: true}
    expect(PhaseLeadRequest.count).to eq 0
    PhaseLeadRequest.load_phase_leads_from_arrays(args)
    expect(PhaseLeadRequest.count).to eq 45
    pp PhaseLeadRequest.data_for_mon(@mon411)
  end
end


may_2 =[
  ['Jaclyn','Mihai','Sarah','Sarah','Mihai'],
  ['Seba','Jaclyn','Shambhavi','Shambhavi','Julian'],
  ['Mihai','Shambhavi','Julian','Seba','Jaclyn'],
  ['Sarah','Jaclyn','Sarah','Jaclyn',''],
  ['Seba','Mihai','Mihai','Shambhavi','Shambhavi'],
  ['Jaclyn','Julian','Jaclyn','Seba','PROJECTS'],
  ['Mihai','Julian','Sarah','Sarah','Julian'],
  ['Shambhavi','Seba','Julian','Mihai','Seba'],
  ['PROJECTS','PROJECTS','PROJECTS','Julian','']
]
apr_11 = [
  ['Hunter','Jaclyn','Sarah','Sarah','Sarah'],
  ['Seba','Seba','Shambhavi','Shambhavi','Shambhavi'],
  ['Julian','Mihai','Mihai','Julian','Hunter'],
  ['Mihai','Jaclyn','Shambhavi','Jaclyn','Jaclyn'],
  ['Sarah','Seba','Sarah','Shambhavi','Seba'],
  ['Jaclyn','Mihai','Hunter','Hunter','PROJECTS'],
  ['Sarah','Jaclyn','Sarah','Mihai','Seba'],
  ['Julian','Julian','Julian','Shambhavi','Mihai'],
  ['PROJECTS','PROJECTS','PROJECTS','Hunter','Jaclyn']
]
