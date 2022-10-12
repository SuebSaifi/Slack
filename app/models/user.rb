class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :user_channels, dependent: :destroy
  has_many :channels, through: :user_channels, dependent: :destroy
  has_many :messages

  has_many :invitations, dependent: :destroy
  has_many :pending_invitations, ->{where confirmed: false},class_name: "Invitation",foreign_key: "client_id"
  after_update_commit { broadcast_update }

  enum status: %i[online offline away]

  def clients
    clients_i_sent_invitation = Invitation.where(user_id: id,confirmed: true).pluck(:client_id)
    clients_i_got_invitation = Invitation.where(client_id: id,confirmed: true).pluck(:user_id)
    ids = clients_i_got_invitation + clients_i_sent_invitation
    ids.join().to_i
    User.find(ids)
  end
  def self.client_with?(user)
    Invitation.confirmed_record?(id,user.id)
  end

  def send_invitation(user)
    invitations.create(client_id: user.id)
  end

  def status_to_css
    case status
    when "online"
      "bg-success"
    when "offline"
      "bg-warning"
    when "away"
      "bg-danger"
    else
      "bg-dark"
    end
  end

  def broadcast_update
    broadcast_replace_to "user_status", partial: "/users/user_status", user: self
  end
end
