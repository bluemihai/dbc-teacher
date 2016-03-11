describe User do

  before(:each) { @user = FactoryGirl.create(:user, name: 'Default Student', role: 'student') }

  subject { @user }

  it { should respond_to(:name) }

  it "#name returns a string" do
    expect(@user.name).to match 'Default Student'
  end

  it "User#import_from_github works" do
    @garrett = User.create_from_github('booneteam', 'teacher')
    expect(@garrett.name).to match 'Garrett Boone'
    expect(@garrett.role).to match 'teacher'
  end

  context 'scopes' do
    before do
      @teacher1 = FactoryGirl.create(:user, name: 'Teacher 1', role: 'teacher')
      @teacher2 = FactoryGirl.create(:user, name: 'Teacher 2', role: 'teacher')
      @teacher3 = FactoryGirl.create(:user, name: 'Teacher 3', role: 'teacher')      
      @admin = FactoryGirl.create(:user, name: 'Admin', role: 'admin')
      @student1 = FactoryGirl.create(:user, name: 'Student 1', role: 'student')
    end

    it '#self.students should return all students' do
      expect(User.students.count).to eq(2)
    end

    it '#self.teachers should return all teachers' do
      expect(User.teachers.count).to eq(3)
    end    

    it '#self.admins should return all admins' do
      expect(User.admins.count).to eq(1)
    end    

    it '#self.all_teachers should return all teachers and admins' do
      expect(User.all_teachers.count).to eq(4)
    end
  end

end
