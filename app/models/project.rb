class Project < ActiveRecord::Base
  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :tasks
  has_many :sections#, -> { distinct },through: :tasks



def delete_data
  self.tasks.each do |task|
    task.destroy
  end
  self.sections.each do |section|
    section.destroy
  end
end
end
