class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :user_channels
  has_many :channels, through: :user_channels
  has_many :messages

  has_many :invitations, dependent: :destroy
  has_many :pending_invitations, ->{where confirmed: false},class_name: "Invitation",foreign_key: "client_id"

  def clients
    clients_i_sent_invitation = Invitation.where(user_id: id,confirmed: true).pluck(:client_id)
    clients_i_got_invitation = Invitation.where(client_id: id,confirmed: true).pluck(:user_id)
    ids = clients_i_got_invitation + clients_i_sent_invitation
    ids.join().to_i
    User.find(ids)
  end
    debugger

  def self.client_with?(user)
    Invitation.confirmed_record?(id,user.id)
  end

  def send_invitation(user)
    invitations.create(client_id: user.id)
  end
end
