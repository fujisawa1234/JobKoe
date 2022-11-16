class User::PostCommentsController < ApplicationController
  def create
    posts = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = posts.id
    comment.save
    redirect_to post_path(posts)
  end
  
  def destroy
    comment = PostComment.find(params[:id])
    comment.destroy
    redirect_to post_path(params[:post_id])
  end


  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
