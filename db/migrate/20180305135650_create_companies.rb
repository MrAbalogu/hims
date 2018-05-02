class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :address
      t.string :plan
      t.string :contact
      t.references :insurer, foreign_key: true


      t.timestamps
    end
  end
end
