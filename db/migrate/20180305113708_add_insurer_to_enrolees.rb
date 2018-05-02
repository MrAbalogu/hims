class AddInsurerToEnrolees < ActiveRecord::Migration[5.1]
  def change
    add_reference :enrolees, :insurer, foreign_key: true
  end
end
