class Admin::PostsController < ApplicationController
  def index
    @tag_list = Tag.all
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_user_path(@post.user)
  end
end