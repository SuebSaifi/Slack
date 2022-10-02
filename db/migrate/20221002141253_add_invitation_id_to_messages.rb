class AddInvitationIdToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :invitation_id, :integer
  end
end
