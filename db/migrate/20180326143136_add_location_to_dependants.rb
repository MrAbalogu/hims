class AddLocationToDependants < ActiveRecord::Migration[5.1]
  def change
    add_column :dependants, :location, :string
  end
end
