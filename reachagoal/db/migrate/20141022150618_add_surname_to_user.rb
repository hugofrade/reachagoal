class AddSurnameToUser < ActiveRecord::Migration
  def change
    add_column :users, :surname, :text
  end
end
