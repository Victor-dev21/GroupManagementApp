class User < ActiveRecord::Base
  has_secure_password
  has_many :user_projects
  has_many :projects, through: :user_projects

  has_mnay :user_tasks
  has_many :tasks, through: :user_tasks
end
