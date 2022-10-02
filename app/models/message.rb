class Message < ApplicationRecord
  belongs_to :user
  belongs_to :channel, optional: true
  belongs_to :invitation, optional: true
end
  