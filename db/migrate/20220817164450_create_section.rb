class CreateSection < ActiveRecord::Migration[6.1]
  def change
    create_table :sections do |t|
      t.string :name
      t.integer :project_id

      t.timestamps
    end
  end
end
