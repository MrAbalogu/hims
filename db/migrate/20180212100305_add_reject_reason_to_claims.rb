class AddRejectReasonToClaims < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :reject_reason, :text
  end
end
