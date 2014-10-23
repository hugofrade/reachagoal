class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.text :icon
      t.text :type_badge

      t.timestamps
    end
  end
end
