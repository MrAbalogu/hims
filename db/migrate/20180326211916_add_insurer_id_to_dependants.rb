class AddInsurerIdToDependants < ActiveRecord::Migration[5.1]
  def change
    add_reference :dependants, :insurer, foreign_key: true
  end
end
