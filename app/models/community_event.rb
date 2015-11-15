class CommunityEvent < ActiveRecord::Base
  belongs_to :community
  belongs_to :event

  validates :event_id, presence: true
  validates :community_id, presence: true
end
