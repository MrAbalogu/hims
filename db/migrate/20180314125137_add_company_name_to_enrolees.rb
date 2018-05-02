class AddCompanyNameToEnrolees < ActiveRecord::Migration[5.1]
  def change
    add_column :enrolees, :company_name, :string
  end
end
