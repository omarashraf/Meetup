class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comments_params)
    @user = current_user
    @post = Post.find(params[:id])

    if @comment.save
      sql_comments = "INSERT INTO comments_users_and_posts (user_id, post_id, comment_id) VALUES (#{@user.id}, #{@post.id}, #{@comment.id})"
      execute = ActiveRecord::Base.connection.execute(sql_comments)
      redirect_to @post
    else
      redirect_to @post
    end
  end

  protected
  def comments_params
    params.require(:comment).permit(:content)
  end
end
