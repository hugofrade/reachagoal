class CreateObjectiveComments < ActiveRecord::Migration
  def change
    create_table :objective_comments do |t|
      t.integer :user_id
      t.integer :objective_id
      t.text :comment

      t.timestamps
    end
  end
end
