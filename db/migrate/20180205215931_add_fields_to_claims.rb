class AddFieldsToClaims < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :attachment, :string
    add_column :claims, :description, :text
    add_column :claims, :member_name, :string
  end
end
