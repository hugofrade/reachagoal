class CreateMoneyboxes < ActiveRecord::Migration
  def change
    create_table :moneyboxes do |t|
      t.string :codenumber

      t.timestamps
    end
  end
end
