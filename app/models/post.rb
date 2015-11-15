class Post < ActiveRecord::Base
  belongs_to :user

  validates :user_sender_id, presence: true
  validates :user_receiver_id, presence: true
  validates :content, presence: true

  has_and_belongs_to_many :users
  has_and_belongs_to_many :comments

  belongs_to :community
  belongs_to :event
end
