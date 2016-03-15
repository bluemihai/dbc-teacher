class User < ActiveRecord::Base
  enum role: [:student, :teacher, :mentor, :admin, :staff]

  after_initialize :set_default_role, :if => :new_record?
  has_many :teacher_interactions, foreign_key: :student_id
  has_many :student_interactions, foreign_key: :teacher_id
  belongs_to :cohort
  belongs_to :location#, required: true   TODO: is this desirable? cause it sure breaks the specs

  scope :students, -> {where(role: 0).order(:name)}
  scope :teachers, -> {where(role: 1).order(:name)}
  scope :mentors, -> {where(role: 2).order(:name)}
  scope :admins, -> {where(role: 3).order(:name)}
  scope :staff, -> {where(role: 4).order(:name)}

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
      user.github_login = auth['login']
      user.github_hash = auth['extra']['raw_info'] if auth['extra']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

  def self.create_from_github(username, location, role='student')
    existing = User.find_by_github_if_existing(username)
    if existing
      puts "Skipping and returning #{username} — already exists."
      return existing
    end
    raise "Location is nil" if location.nil?
    user_api = JSON.parse eat("https://api.github.com/users/#{username}?client_id=#{ENV['OMNIAUTH_PROVIDER_KEY']}&client_secret=#{ENV['OMNIAUTH_PROVIDER_SECRET']}")
    create! do |user|
      user.provider = 'github'
      user.uid = user_api['id']
      user.github_hash = user_api
      user.name = user_api['name']
      user.role = role
      user.location = location
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
