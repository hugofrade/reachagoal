class CreateObjectiveValues < ActiveRecord::Migration
  def change
    create_table :objective_values do |t|
      t.integer :user_id
      t.integer :objective_id
      t.float :value
      t.string :description

      t.timestamps
    end
  end
end
