class AddSymbolToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :symbol, :text
  end
end
