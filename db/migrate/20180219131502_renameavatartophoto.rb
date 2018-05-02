class Renameavatartophoto < ActiveRecord::Migration[5.1]
  def change
  	rename_column :insurers, :avatar, :photo
  	rename_column :providers, :avatar, :photo
  end
end
