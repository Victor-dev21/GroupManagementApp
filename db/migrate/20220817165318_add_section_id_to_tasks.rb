class AddSectionIdToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :section_id, :integer
  end
end
