class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @tag_list = Tag.all
    @posts = Post.page(params[:page]).per(10)
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
