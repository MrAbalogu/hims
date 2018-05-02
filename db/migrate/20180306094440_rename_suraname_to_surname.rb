class RenameSuranameToSurname < ActiveRecord::Migration[5.1]
  def change
  	rename_column :enrolees, :suraname, :surname
  end
end
