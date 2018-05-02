class RenamecompanyTocompanyId < ActiveRecord::Migration[5.1]
  def change
  	rename_column :enrolees, :company, :company_id
  end
end
