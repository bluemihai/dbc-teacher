class User < ActiveRecord::Base
  enum role: [:student, :teacher, :mentor, :admin, :staff]

  after_initialize :set_default_role, :if => :new_record?
  has_many :teacher_interactions, foreign_key: :student_id
  has_many :student_interactions, foreign_key: :teacher_id
  belongs_to :cohort, foreign_key: :member_id

  scope :teachers, -> {where(role: 1)}
  scope :students, -> {where(role: 0)}
  scope :admins, -> {where(role: 3)}

  def self.all_teachers
    User.teachers + User.admins
  end

  def set_default_role
    if User.count == 0
      self.role ||= :admin
    else
      self.role ||= :student
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.github_hash = auth['extra']['raw_info'] if auth['extra']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

  def self.create_from_github(username, role='student')
    user_api = JSON.parse eat('https://api.github.com/users/' + username)
    create! do |user|
      user.provider = 'github'
      user.uid = user_api['id']
      user.github_hash = user_api
      user.name = user_api['name']
      user.role = role
    end
  end

  def avatar_url
    github_hash['avatar_url'] if github_hash
  end

  def email
    github_hash['email'] if github_hash
  end

end
