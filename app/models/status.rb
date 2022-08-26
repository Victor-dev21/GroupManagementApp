class Status < ApplicationRecord
  belongs_to :tasks
  belongs_to :project
  belongs_to :section

end
