class AddNomeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :n, :string
  end
end
