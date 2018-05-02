class CreateClaims < ActiveRecord::Migration[5.1]
  def change
    create_table :claims do |t|
      t.string :facility_name
      t.datetime :date
      t.string :authorization_number
      t.decimal :total_requested_amount, default: 0
      t.decimal :authorized_amount, default: 0
      t.decimal :rejected_amount, default: 0
      t.string :authority_name
      t.references :provider, foreign_key: true
      t.string :authority_designation
      t.string :member_number
      t.integer :status, default: 0
      t.references :insurer, foreign_key: true

      t.timestamps
    end
  end
end
