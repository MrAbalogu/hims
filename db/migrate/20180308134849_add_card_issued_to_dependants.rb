class AddCardIssuedToDependants < ActiveRecord::Migration[5.1]
  def change
  	add_column :dependants, :card_issued, :boolean, default: false
  end
end
