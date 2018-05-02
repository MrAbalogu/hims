class RenameTypeServiceType < ActiveRecord::Migration[5.1]
  def change
    rename_column :services, :type, :service_type
  end
end
