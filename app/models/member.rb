class Member < ActiveRecord::Base
  belongs_to :community
  belongs_to :user

  validates :user_id, presence: true
  validates :community_id, presence: true
end
