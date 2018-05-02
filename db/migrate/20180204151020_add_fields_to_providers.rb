class AddFieldsToProviders < ActiveRecord::Migration[5.1]
  def change
    add_column :providers, :company_name, :string
    add_column :providers, :facility_type, :string
    add_column :providers, :category, :string
    add_column :providers, :region, :string
    add_column :providers, :phone, :string
    add_column :providers, :address, :text
    add_column :providers, :payment_option, :string
    add_column :providers, :acc_no, :string
    add_column :providers, :acc_name, :string
    add_column :providers, :acc_bank, :string
    add_column :providers, :avatar, :string
  end
end
