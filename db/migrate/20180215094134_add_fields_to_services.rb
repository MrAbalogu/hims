class AddFieldsToServices < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :total_cost, :decimal
    add_column :services, :vetted_cost, :decimal
  end
end
