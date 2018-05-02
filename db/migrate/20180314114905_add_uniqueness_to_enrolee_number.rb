class AddUniquenessToEnroleeNumber < ActiveRecord::Migration[5.1]
  def change
  	change_column :enrolees, :enrolee_number, :string, unique: true
  	change_column :dependants, :enrolee_number, :string, unique: true
  end
end
