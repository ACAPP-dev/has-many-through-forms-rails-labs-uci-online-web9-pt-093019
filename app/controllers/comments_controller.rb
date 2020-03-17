class CommentsController < ApplicationController

  def create
    comment = Comment.create(comment_params)
    @post = Post.find(comment.post_id)
    @post.comments << comment
    if !params[:comment][:user_id].empty?
      @user = User.find(comment.user_id)
      @user.comments << comment
    end
    redirect_to comment.post
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id, user_attributes:[:username, :email])
  end
end
