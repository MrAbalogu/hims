class AddEnroleeNumberToDependants < ActiveRecord::Migration[5.1]
  def change
    add_column :dependants, :enrolee_number, :string
  end
end
