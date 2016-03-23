class Interaction < ActiveRecord::Base
  belongs_to :teacher, class_name: 'User', required: true
  belongs_to :student, class_name: 'User', required: true
  belongs_to :challenge
end
