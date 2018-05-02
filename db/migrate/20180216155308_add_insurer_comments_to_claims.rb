class AddInsurerCommentsToClaims < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :insurer_comment, :text
  end
end
