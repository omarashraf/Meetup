class EventsController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def delete
  end

  def show
    @posts = Post.where(event_id: params[:id])
    sql_event_members = "SELECT * FROM event_members WHERE event_id = #{params[:id]}"
    @event_members = ActiveRecord::Base.connection.execute(sql_event_members)
    unless params[:post].nil?
      @post_new = Post.new(content: params[:post][:post_content], event_id: params[:id], user_sender_id: 3, user_receiver_id: nil)
    end

    if @post_new != nil
      if @post_new.save!
        redirect_to event_show_path(params[:id])
      else
        #display error message
        render plain: "Fail"
      end
    end
  end
end
