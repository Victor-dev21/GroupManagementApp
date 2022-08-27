class AddCreatorToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :creator, :string
  end
end
