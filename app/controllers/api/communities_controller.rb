class Api::CommunitiesController < Api::BaseController
  def index
    respond_with @communities = Community.all
  end

  def show
    @community = Community.find(params[:id])

    # All posts in this community
    @posts = Post.where(community_id: @community.id).order(created_at: :desc)

    # All events of this community
    tmp_events = CommunityEvent.where(community_id: @community.id)
    @events = []
    tmp_events.each do |e|
      @events += [Event.find_by(id: e.event_id)]
    end

    # All members of this community
    tmp_users = Member.where(community_id: @community.id)
    @members = []
    tmp_users.each do |u|
      @members += [User.find_by(id: u.user_id)]
    end
  end

  def create
    @community = Community.new(comm_params)

    @community.user_id = current_user.id

    if @community.save
      @member = @community.members.build(user: current_user)
      @member.save
      respond_with @community
    else
      render status: :internal_server_error
    end
  end

  def update
    @community = Commnity.find(params[:id])

    if @community.update(comm_params)
      respond_with @community
    else
      render status: :internal_server_error
    end
  end

  def destroy
    @community = Community.find(params[:id])
    @community.destroy

    respond_with communities_path
  end

  def join_community
    @community = Community.find(params[:community_id])
    @member = @community.members.build(user: current_user)
    @member.save

    respond_with @community
  end

  def leave_community
    @community = Community.find(params[:community_id])
    @member = Member.where(user_id: current_user.id, community_id: @community.id)
    @member.first.destroy

    respond_with @community
  end

  protected
  def comm_params
    params.require(:community).permit(:comName, :description)
  end
end
