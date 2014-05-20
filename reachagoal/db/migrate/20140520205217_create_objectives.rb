class CreateObjectives < ActiveRecord::Migration
  def change
    create_table :objectives do |t|
      t.string :name
      t.text :description
      t.date :start_day
      t.date :end_day
      t.integer :price
      t.integer :objective_type
      t.integer :privacy

      t.timestamps
    end
  end
end
