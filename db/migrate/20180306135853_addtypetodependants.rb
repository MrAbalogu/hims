class Addtypetodependants < ActiveRecord::Migration[5.1]
  def change
  	add_column :dependants, :type, :string
  end
end
