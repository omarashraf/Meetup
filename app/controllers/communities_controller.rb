class CommunitiesController < ApplicationController
  def index
    @communities = Community.all
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

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(comm_params)

    @community.user_id = current_user.id

    if @community.save
      @member = @community.members.build(user: current_user)
      @member.save
      redirect_to @community
    else
      render 'new'
    end
  end

  def edit
    @Community = Community.find(params[:id])
  end

  def update
    @community = Commnity.find(params[:id])

    if @community.update(comm_params)
      redirect_to @community
    else
      render 'edit'
    end
  end

  def destroy
    @community = Community.find(params[:id])
    @community.destroy

    redirect_to communities_path
  end

  def join_community
    @community = Community.find(params[:community_id])
    @member = @community.members.build(user: current_user)
    @member.save

    redirect_to @community
  end

  def leave_community
    @community = Community.find(params[:community_id])
    @member = Member.where(user_id: current_user.id, community_id: @community.id)
    @member.first.destroy

    redirect_to @community
  end

  protected
  def comm_params
    params.require(:community).permit(:comName, :description)
  end
end
