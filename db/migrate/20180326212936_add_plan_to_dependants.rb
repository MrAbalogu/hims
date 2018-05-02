class AddPlanToDependants < ActiveRecord::Migration[5.1]
  def change
    add_column :dependants, :plan, :string
  end
end
