class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.integer :user_id
      t.integer :client_id
      t.boolean :confirmed, default: false
      t.timestamps
    end
  end
end
