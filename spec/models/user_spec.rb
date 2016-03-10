describe User do

  before(:each) { @user = FactoryGirl.create(:user, role: 'student') }

  subject { @user }

  it { should respond_to(:name) }

  it "#name returns a string" do
    expect(@user.name).to match 'Test User'
  end

  context 'scopes' do
    before do
      @teacher1 = FactoryGirl.create(:user, role: 'teacher')
      @teacher2 = FactoryGirl.create(:user, role: 'teacher')
      @teacher3 = FactoryGirl.create(:user, role: 'teacher')      
      @student1 = FactoryGirl.create(:user, role: 'student')
    end

    it '#self.students should return all students' do
      expect(User.students.count).to eq(2)
    end

    it '#self.teachers should return all teachers' do
      expect(User.teachers.count).to eq(3)
    end
    
  end

end
