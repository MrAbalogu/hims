class RenameTypeToDependantType < ActiveRecord::Migration[5.1]
  def change
  	rename_column :dependants, :type, :dependant_type
  end
end
