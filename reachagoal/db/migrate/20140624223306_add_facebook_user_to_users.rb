class AddFacebookUserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_user, :string
  end
end
