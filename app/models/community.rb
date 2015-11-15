class Community < ActiveRecord::Base
  belongs_to :user  # Admin

  validates :comName, presence: true
  validates :description, presence: true
  validates :user_id, presence: true

  has_many :posts
  has_many :users, through: :members
  has_many :events, through: :community_events
end
