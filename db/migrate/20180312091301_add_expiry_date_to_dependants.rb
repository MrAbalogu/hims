class AddExpiryDateToDependants < ActiveRecord::Migration[5.1]
  def change
    add_column :dependants, :expiry_date, :datetime, default: Time.now+1.year
  end
end
