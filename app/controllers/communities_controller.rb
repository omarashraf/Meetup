class CommunitiesController < ApplicationController
  def index
  end

  def show
    @posts = Post.where(community_id: params[:id])
    sql_events_communities = "SELECT * FROM community_events where community_id = #{params[:id]}"
    @events_communities = ActiveRecord::Base.connection.execute(sql_events_communities)
    @members = Member.where(community_id: params[:id])

    unless params[:post].nil?
      @post_new = Post.new(content: params[:post][:post_content], community_id: params[:id], user_sender_id: 3, user_receiver_id: nil)
    end

    if @post_new != nil
      if @post_new.save!
        redirect_to community_show_path(params[:id])
      else
        #display error message
        render plain: "Fail"
      end
    end

  end

  def delete
  end

  def edit
  end

  def new
  end

end
