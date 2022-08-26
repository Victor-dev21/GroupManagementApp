class Section < ApplicationRecord
  has_many :tasks
  belongs_to :project


  def display_info
    "Section Name:#{self.name} Status:#{self.status}  Tasks:#{self.tasks.length}"
  end
end
