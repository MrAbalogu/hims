class AddClaimNoToClaim < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :claim_no, :string
  end
end
