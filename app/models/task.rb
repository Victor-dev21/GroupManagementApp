class Task < ActiveRecord::Base
  belongs_to :section
  belongs_to :project
  has_many :user_tasks
  has_many :users, through: :user_tasks

  accepts_nested_attributes_for :section, reject_if: proc { |attributes| attributes['name'].blank? }

  def section_attributes=(section)
    #section = Section.find_or_create_by(name:section[:name])
    #binding.pry
    section = Section.find_or_create_by(name: section[:name])
    #binding.pry
    #self.section.update(project_id: self.project.id)
    #self.section.update(status: self.status)
    self.section_id = section.id #(section_id: section.id)
    #binding.pry
  end
end
