class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :username, :password, presence: true

  validates_uniqueness_of  :username
  has_many :user_projects
  has_many :projects, through: :user_projects
  #has_many :tasks, through: :projects
  has_many :user_tasks
  has_many :tasks, through: :user_tasks
  #has_many :tasks, through: :projects
end
