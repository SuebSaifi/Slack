class AddAttachementToMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :attachements, :string
  end
end
