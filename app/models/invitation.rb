class Invitation < ApplicationRecord

	belongs_to :user
	belongs_to :client, class_name: "User"

	has_many :messages, dependent: :destroy

	def self.reacted?(id1,id2)
    case1 = !Invitation.where(user_id: id1,client_id: id2).empty?
    case2 = !Invitation.where(user_id: id2,client_id: id1).empty?
    case1 || case2
  end

	def self.confirmed_record?(id1,id2)
	  case1 = !Invitation.where(user_id: id1,client_id: id2,confirmed: true).empty?
	  case2 = !Invitation.where(user_id: id2,client_id: id1,confirmed: true).empty?
	  case1 || case2
	end

	def self.find_invitation(id1,id2)
	 if Invitation.where(user_id: id1,client_id: id2,confirmed: true).empty?
	  Invitation.where(user_id: id2,client_id: id1,confirmed: true)[0].id
	 else
	  Invitation.where(user_id: id1,client_id: id2,confirmed: true)[0].id
	 end
	end
end
