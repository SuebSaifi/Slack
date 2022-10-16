class AddAttachmetsToMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :attachments, :string
  end
end
