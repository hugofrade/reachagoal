class AddCategoryIdToObjective < ActiveRecord::Migration
  def change
    add_column :objectives, :category_id, :integer
  end
end
