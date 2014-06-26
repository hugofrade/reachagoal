class CreateUserBadges < ActiveRecord::Migration
  def change
    create_table :user_badges do |t|
      t.integer :giver_id
      t.integer :receiver_id
      t.integer :badge_id

      t.timestamps
    end
  end
end
