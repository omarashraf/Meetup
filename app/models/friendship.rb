class Friendship < ActiveRecord::Base
  belongs_to :user
  
  validates :user_request_sender_id, presence: true
  validates :user_request_receiver_id, presence: true
end
