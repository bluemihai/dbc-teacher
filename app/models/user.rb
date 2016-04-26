class User < ActiveRecord::Base
  enum role: [:student, :teacher, :mentor, :admin, :staff]

  after_initialize :set_default_role, :if => :new_record?
  has_many :teacher_interactions, foreign_key: :student_id
  has_many :student_interactions, foreign_key: :teacher_id
  belongs_to :cohort
  belongs_to :location#, required: true   TODO: is this desirable? cause it sure breaks the specs
  has_many :phase_lead_requests, foreign_key: :teacher_id
  belongs_to :advisor, class_name: 'User'
  has_many :advisees, foreign_key: :advisor_id

  scope :students, -> {where(role: 0).order(:name)}
  scope :teachers, -> {where(role: 1).order(:name)}
  scope :mentors, -> {where(role: 2).order(:name)}
  scope :admins, -> {where(role: 3).order(:name)}
  scope :staff, -> {where(role: 4).order(:name)}

  # validates :github_login, presence: true

  def self.roles_humanized
    User.roles.keys.map {|role| [role.titleize,role]}
  end

  def student_github_cohort
    "#{name} (#{github_login}, #{cohort.try(:current_phase)}-#{cohort.try(:name)})"
  end

  def student_cohort
    "#{name} (#{cohort.try(:phase)}-#{cohort.try(:name)})"
  end

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

  def self.create_from_github(username, role='student', cohort=nil)
    raise 'no username!' unless username
    existing = User.find_by_github_if_existing(username)
    if existing
      puts "Skipping and returning #{username} — already exists."
      return existing #TODO: add above puts as flash notice for users
    end
    github_api_url = "https://api.github.com/users/#{username}?access_token=#{ENV['GITHUB_PERSONAL_ACCESS_TOKEN']}"
    user_api = JSON.parse eat(github_api_url)
    create! do |user|
      user.provider = 'github'
      user.uid = user_api['id']
      user.github_hash = user_api
      user.github_login = user_api['login']
      user.name = user_api['name'] || 'Name Me Later'
      user.role = role
      user.cohort_id = cohort.try(:id)
    end
  end

  def self.github_login_exists?(github_login)
    User.all.map{ |u| u.github }.include? github_login
  end

  def self.find_by_github_if_existing(github_login)
    User.find_by(github_login: github_login)
  end

  def avatar_url
    github_hash['avatar_url'] if github_hash
  end

  def email
    github_hash['email'] if github_hash
  end

  def github
    github_hash['login'] if github_hash
  end

end
