class RenameCardIssuedToBool < ActiveRecord::Migration[5.1]
  def change
  	change_column :enrolees, :card_issued, :boolean, default: false
  end
end
