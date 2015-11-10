class ProfilesController < ApplicationController
  def index
  	@user = User.find(3)
  	@posts_me = Post.where(user_sender_id: 3, user_receiver_id: nil)
  	@posts_others = Post.where(user_receiver_id: 3)
  	@friends = Friendship.where(user_request_sender_id: 3, accept: true)
  	@friends2 = Friendship.where(user_request_receiver_id: 3, accept: true)
  	@requests = Friendship.where(user_request_receiver_id: 3, accept: nil)
  	@requests_pending = Friendship.where(user_request_sender_id: 3, accept: nil)
  end
end
