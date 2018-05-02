class AddAttachmentsToClaims < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :attachments, :json
  end
end
