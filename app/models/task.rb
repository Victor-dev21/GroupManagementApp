class Task < ActiveRecord::Base
  belongs_to :section
  belongs_to :project
  has_many :user_tasks
  has_many :users, through: :user_tasks
  accepts_nested_attributes_for :section, reject_if: :all_blank, allow_destroy: true


  def section_attributes=(section)
    if(!section[:name].empty?)
      section = Section.find_or_create_by(name: section[:name],project_id: section[:project_id])
      #binding.pry
      section.status = section[:status]
      section.save
      #binding.pry
      #self.section.update(project_id: self.project.id)
      #self.section.update(status: self.status)
      self.section_id = section.id #(section_id: section.id)
      #binding.pry
      #binding.pry
      self.save
    end
    #section = Section.find_or_create_by(name:section[:name])
    #binding.pry

  end
end
