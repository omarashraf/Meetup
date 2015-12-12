class Api::EventsController < Api::BaseController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])

    # All posts in this event
    @posts = Post.where(event_id: @event.id).order(created_at: :desc)

    # All RSVPees to this event
    sql_event_members_going = "SELECT * FROM event_members WHERE event_id = #{@event.id} AND rsvp = 1"
    tmp_users_going = ActiveRecord::Base.connection.execute(sql_event_members_going)
    @rsvp_going = []
    tmp_users_going.each do |u|
      @rsvp_going += [User.find_by(id: u['user_id'])]
    end

    sql_event_members_notGoing = "SELECT * FROM event_members WHERE event_id = #{@event.id} AND rsvp = 0"
    tmp_users_notGoing = ActiveRecord::Base.connection.execute(sql_event_members_notGoing)
    @rsvp_notGoing = []
    tmp_users_notGoing.each do |u|
      @rsvp_notGoing += [User.find_by(id: u['user_id'])]
    end
  end

  def create
    @event = Event.new(ev_params)

    @event.user_id = current_user.id

    if params[:event][:community_id] == "- Select a category -"
			#@forum.category = nil
			params[:event][:community_id] = nil
		end

    if @event.save
      sql_event_members = "INSERT INTO event_members (event_id, user_id, rsvp) VALUES (#{@event.id}, #{current_user.id}, 1)"
      tmp_users = ActiveRecord::Base.connection.execute(sql_event_members)
      respond_with @event
    else
      render status: :internal_server_error
    end
  end

  def rsvp_going
    @event = Event.find(params[:event_id])
    userId = current_user.id

    if isNotGoing?(@event.id, userId)
      sql = "DELETE FROM event_members WHERE user_id = #{userId}"
      execute = ActiveRecord::Base.connection.execute(sql)
    end

    sql_event_members = "INSERT INTO event_members (event_id, user_id, rsvp) VALUES (#{@event.id}, #{userId}, 1)"
    tmp_users = ActiveRecord::Base.connection.execute(sql_event_members)

    respond_with @event
  end

  def rsvp_notGoing
    @event = Event.find(params[:event_id])
    userId = current_user.id

    if isGoing?(@event.id, userId)
      sql = "DELETE FROM event_members WHERE user_id = #{userId}"
      execute = ActiveRecord::Base.connection.execute(sql)
    end

    sql_event_members = "INSERT INTO event_members (event_id, user_id, rsvp) VALUES (#{@event.id}, #{userId}, 0)"
    tmp_users = ActiveRecord::Base.connection.execute(sql_event_members)

    respond_with @event
  end

  protected
  def ev_params
    params.require(:event).permit(:eventName, :description, :community_id)
  end
end
