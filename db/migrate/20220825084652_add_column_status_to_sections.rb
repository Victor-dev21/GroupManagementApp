class AddColumnStatusToSections < ActiveRecord::Migration[6.1]
  def change
     add_column :sections, :status, :string
  end
end
