class Channel < ApplicationRecord
	has_many :user_channels
	has_many :users, through: :user_channels
	has_many :messages

	# after_save :channel_user_to_admin

	# def channel_user_to_admin
	# 	current_user.update(role: "Admin")
	# end
end
