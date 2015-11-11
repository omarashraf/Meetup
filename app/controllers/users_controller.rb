class UsersController < ApplicationController
  def index
  end

  def new
  end

  def delete
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
  	@posts_me = Post.where(user_sender_id: params[:id], user_receiver_id: nil)
  	@posts_others = Post.where(user_receiver_id: params[:id])
  	@friends = Friendship.where(user_request_sender_id: params[:id], accept: true)
  	@friends2 = Friendship.where(user_request_receiver_id: params[:id], accept: true)
  	@requests = Friendship.where(user_request_receiver_id: params[:id], accept: nil)
  	@requests_pending = Friendship.where(user_request_sender_id: params[:id], accept: nil)
  	sql = "SELECT * FROM comments_users_and_posts WHERE post_id = #{params[:id]}"
  	@result = ActiveRecord::Base.connection.execute(sql)
  	@result.to_a
  end
end
