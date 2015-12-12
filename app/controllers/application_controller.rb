class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

protected

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def current_user?
    current_user.present?
  end
  helper_method :current_user?

  def authenticate_user!
    unless current_user?
      redirect_to root_path, alert: 'Please login first'
    end
  end

  def isMember?(communityId, userId)
    !Member.where(user_id: userId, community_id: communityId).empty?
  end
  helper_method :isMember?

  def isGoing?(eventId, userId)
    sql_event_members = "SELECT * FROM event_members WHERE event_id = #{eventId} AND user_id = #{userId} AND rsvp = 1"

    tmp_users = ActiveRecord::Base.connection.execute(sql_event_members)

    !tmp_users.empty?
  end
  helper_method :isGoing?

  def isNotGoing?(eventId, userId)
    sql_event_members = "SELECT * FROM event_members WHERE event_id = #{eventId} AND user_id = #{userId} AND rsvp = 0"

    tmp_users = ActiveRecord::Base.connection.execute(sql_event_members)

    !tmp_users.empty?
  end
  helper_method :isNotGoing?

  def request_pending?(userA, userB)
    !Friendship.where(user_request_sender_id: userA, user_request_receiver_id: userB, accept: nil).empty? || !Friendship.where(user_request_sender_id: userB, user_request_receiver_id: userA, accept: nil).empty?
  end
  helper_method :request_pending?

  def friends?(userA, userB)
    !Friendship.where(user_request_sender_id: userA, user_request_receiver_id: userB, accept: true).empty? || !Friendship.where(user_request_sender_id: userB, user_request_receiver_id: userA, accept: true).empty?
  end
  helper_method :friends?

  def no_request?(userA, userB)
    !request_pending?(userA, userB) && !friends?(userA, userB)
  end
  helper_method :no_request?
end
