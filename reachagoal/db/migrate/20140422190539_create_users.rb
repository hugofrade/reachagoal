class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :moneybox
      t.string :photo
      t.string :place
      t.integer :currency_id
      t.string :ffacebook_user
      t.string :twitter_user

      t.timestamps
    end
  end
end
