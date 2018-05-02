class AddLocationToEnrolees < ActiveRecord::Migration[5.1]
  def change
    add_column :enrolees, :location, :string
  end
end
