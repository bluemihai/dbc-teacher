FactoryGirl.define do
  factory :interaction do
    student_id 1
    teacher_id 1
    minutes 1
    topic "MyString"
    challenge_id 1
    rating 1
    learned "MyText"
  end
end
