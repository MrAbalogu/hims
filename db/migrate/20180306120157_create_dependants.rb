class CreateDependants < ActiveRecord::Migration[5.1]
  def change
    create_table :dependants do |t|
      t.string :surname
      t.string :firstname
      t.string :middlename
      t.datetime :dob
      t.string :sex
      t.string :blood_group
      t.string :primary_hospital
      t.string :secondary_hospital
      t.string :genotype
      t.string :photo
      t.references :enrolee, foreign_key: true

      t.timestamps
    end
  end
end
