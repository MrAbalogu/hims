class AddCategoryToService < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :category, :string, default: 'none'
  end
end
