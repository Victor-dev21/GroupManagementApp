class Task < ActiveRecord::Base
  belongs_to :section
  belongs_to :project
  has_many :user_tasks
  has_many :users, through: :user_tasks
  accepts_nested_attributes_for :section, reject_if: :all_blank, allow_destroy: true


  def section_attributes=(section)

    if(!section[:name].empty?)
      #binding.pry
      status_temp = section[:status]
      creator_temp = section[:creator]
      section = Section.find_or_create_by(name: section[:name],project_id: section[:project_id])
      #section.status = section[:status]
      section.update(status:status_temp,creator:creator_temp)
      section.save
      self.section = section
      self.save
      #binding.pry
    end
  end

  def assign_task(session)
    if self.assignee.nil?
      self.update(assignee: self.creator)
    #  binding.pry
    end
    self.save
    #binding.pry
  end


  def display_assignee
    if(self.assignee.nil?)
      return ""
    else
      return User.find(self.assignee).name
    end
  end
end
