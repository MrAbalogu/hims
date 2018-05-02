class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string :type
      t.string :name
      t.decimal :cost, default: 0.0
      t.integer :qty, default: 1
      t.text :description
      t.references :claim, foreign_key: true
      t.timestamps
    end
  end
end
