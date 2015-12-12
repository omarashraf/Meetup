class Api::UsersController < Api::BaseController
  def show
    if current_user?
      @user = User.find(params[:id])

      # All posts on this user's profile
      posts = Post.where("user_sender_id=? OR user_receiver_id=?", @user.id, @user.id).order(created_at: :desc)
      @posts = []
      posts.each do |post|
        if post.community_id == nil && post.event_id == nil
          @posts += [post]
        end
      end

      # All communities this user has joined
      tmp_users = Member.where(user_id: @user.id)
      @communities = []
      tmp_users.each do |c|
        @communities += [Community.find_by(id: c.community_id)]
      end

      # All events to which this user RSVPed
      sql_event_members = "SELECT * FROM event_members WHERE user_id = #{@user.id}"
      tmp_events = ActiveRecord::Base.connection.execute(sql_event_members)
      @events = []
      tmp_events.each do |e|
        @events += [Event.find_by(id: e['event_id'])]
      end

      # All friends of this user
      # Without Facebook
      friendships = Friendship.where("user_request_sender_id=? OR user_request_receiver_id=? AND accept=?", @user.id, @user.id, true)
      @friends = []
      friendships.each do |fr|
        userA = User.find_by(id: fr.user_request_sender_id)
        userB = User.find_by(id: fr.user_request_receiver_id)
        if @user.id == userA.id
          @friends += [userB]
        else
          @friends += [userA]
        end
      end
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      respond_with root_path
    else
      render :status: :internal_server_error
    end
  end

  def add_friend
    @user = User.find(params[:user_id])
    @friends_to_be = Friendship.create(user_request_sender_id: current_user.id, user_request_receiver_id: @user.id, accept: nil)
    @friends_to_be.save

    respond_with @user
  end

  def remove_friend
    @user = User.find(params[:user_id])

    @destroyed_friends1 = Friendship.where(user_request_sender_id: current_user.id, user_request_receiver_id: @user.id, accept: true)
    if @destroyed_friends1.present?
      @destroyed_friends1.first.destroy
    end

    @destroyed_friends2 = Friendship.where(user_request_sender_id: @user.id, user_request_receiver_id: current_user.id, accept: true)
    if @destroyed_friends2.present?
      @destroyed_friends2.first.destroy
    end

    respond_with @user
  end

  def requests
    @requests = Friendship.where(user_request_receiver_id: current_user.id, accept: nil)
  end

  def accept_request
    @request = Friendship.find(params[:request_id])
    @request.update(accept: true)

    respond_with current_user
  end

  def reject_request
    @request = Friendship.find(params[:request_id])
    @request.destroy

    respond_with current_user
  end

  protected
  def user_params
    params.require(:user).permit(:f_name, :l_name, :email, :password, :location, :day, :month, :year, :profile_picture, :gender)
  end
end
