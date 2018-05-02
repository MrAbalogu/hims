class AddDateToEnrolees < ActiveRecord::Migration[5.1]
  def change
    add_column :enrolees, :date, :datetime
  end
end
