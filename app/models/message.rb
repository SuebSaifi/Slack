class Message < ApplicationRecord
  belongs_to :user
  belongs_to :channel, optional: true
  belongs_to :invitation, optional: true

  after_create_commit { broadcast_append_to self.channel }
  after_create_commit { broadcast_prepend_to self.invitation }
end
