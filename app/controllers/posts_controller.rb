class PostsController < ApplicationController
  def new
  end

  def index
  end

  def edit
  end

  def delete
  end

  def show
    sql_post_comments = "SELECT * FROM comments_users_and_posts WHERE post_id = #{params[:id]}"
    @post_comments = ActiveRecord::Base.connection.execute(sql_post_comments)
    unless params[:comment].nil?
      @comment_new = Comment.new(content: params[:comment][:comment_content])
    end

    if @comment_new != nil
      if @comment_new.save!
        sql_comment_post = "INSERT INTO comments_users_and_posts (user_id, post_id, comment_id) VALUES 
        (3, #{params[:id]}, #{@comment_new.id})"
        @comment_post = ActiveRecord::Base.connection.execute(sql_comment_post)
        redirect_to post_show_path(params[:id])
      else
        #display error message
        render plain: "Fail"
      end
    end
  end
end
