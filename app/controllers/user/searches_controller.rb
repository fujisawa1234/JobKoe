class User::SearchesController < ApplicationController
  def search
    @posts = Post.search(params[:word])
    @word = params[:word]
  end
end
