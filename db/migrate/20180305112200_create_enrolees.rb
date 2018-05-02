class CreateEnrolees < ActiveRecord::Migration[5.1]
  def change
    create_table :enrolees do |t|
      t.string :suraname
      t.string :firstname
      t.string :middlename
      t.string :company
      t.string :enrolee_number
      t.string :primary_provider
      t.string :secondary_provider
      t.string :tertiary_provider
      t.string :phone
      t.string :email
      t.text :address
      t.datetime :dob
      t.string :sex
      t.string :state
      t.integer :cover_status
      t.boolean :card_issued
      t.string :plan
      t.datetime :expiry_date
      t.string :photo

      t.timestamps
    end
  end
end
