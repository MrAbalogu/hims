class ChangeCoverStatus < ActiveRecord::Migration[5.1]
  def change
  	change_column :enrolees, :cover_status, :string, default: 'active'
  end
end
