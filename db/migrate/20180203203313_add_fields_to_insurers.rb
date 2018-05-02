class AddFieldsToInsurers < ActiveRecord::Migration[5.1]
  def change
    add_column :insurers, :company_name, :string
    add_column :insurers, :address, :string
    add_column :insurers, :phone, :string
    add_column :insurers, :description, :text
    add_column :insurers, :facebook, :string
    add_column :insurers, :twitter, :string
    add_column :insurers, :google_plus, :string
    add_column :insurers, :website, :string
    add_column :insurers, :avatar, :string
  end
end
