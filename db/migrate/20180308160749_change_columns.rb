class ChangeColumns < ActiveRecord::Migration[5.1]
  def change
  	change_column :enrolees, :primary_provider, :string
  	change_column :enrolees, :secondary_provider, :string
  	change_column :enrolees, :plan, :string
  	change_column :enrolees, :cover_status, :string
  end
end
