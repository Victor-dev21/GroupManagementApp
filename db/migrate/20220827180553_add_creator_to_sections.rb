class AddCreatorToSections < ActiveRecord::Migration[6.1]
  def change
    add_column :sections, :creator, :integer
  end
end
