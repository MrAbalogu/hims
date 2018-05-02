class AddPhoneToDependants < ActiveRecord::Migration[5.1]
  def change
    add_column :dependants, :phone, :string
  end
end
