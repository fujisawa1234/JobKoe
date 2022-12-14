class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to posts_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def unsubscribe
    user = User.find(params[:id])
    if user == current_user
      render :unsubscribe
    else
      redirect_to posts_path
    end
  end

  #退会機能
  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会処理を完了いたしました"
  end


  private

  def user_params
    params.require(:user).permit(:name,:profile_image)
  end

  #ゲストユーザーはプロフィール編集ができなくする
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to posts_path, notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
