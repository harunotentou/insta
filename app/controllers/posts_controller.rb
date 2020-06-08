class PostsController < ApplicationController
  before_action :require_login, only: %i[new create edit update destroy]

  def index
    # N+1問題に対応
    @posts = Post.all.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    # postに現在のユーザーの情報を付与している
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました'
      redirect_to posts_path
    else
      flash[:danger] = '投稿に失敗しました'
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    # postが現在ログインしているユーザーのpostであるときのみ編集できる
    @post = current_user.posts.find(params[:id])
  end

  def update
    # postが現在ログインしているユーザーのpostであるときのみ編集できる
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      flash[:success] = '投稿を更新しました'
      redirect_to posts_path
    else
      flash[:danger] = '投稿の更新に失敗しました'
      render 'new'
    end
  end

  def destroy
    # postが現在ログインしているユーザーのpostであるときのみ削除できる
    @post = current_user.posts.find(params[:id])
    @post.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to posts_path
  end

  private

  def post_params
    # picturesは配列でパラメータを受け取りたい
    params.require(:post).permit(:content, pictures: [])
  end
end
