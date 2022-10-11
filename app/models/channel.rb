class Channel < ApplicationRecord
	has_many :user_channels, dependent: :destroy
	has_many :users, through: :user_channels, dependent: :destroy
	has_many :messages, dependent: :destroy
  	# after_create_commit { broadcast_append_to channel }

	# after_save :channel_user_to_admin

	# def channel_user_to_admin
	# 	current_user.update(role: "Admin")
	# end
end
