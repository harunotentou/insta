class PostsController < ApplicationController
  before_action :require_login, only: %i[new create edit update destroy]
  before_action :correct_user?, only: %i[edit update destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
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
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = '投稿を更新しました'
      redirect_to posts_path
    else
      flash[:danger] = '投稿の更新に失敗しました'
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to posts_path
  end

  private

  def post_params
      #picturesは配列でパラメータを受け取りたい
    params.require(:post).permit(:content, pictures: [])
  end

  def correct_user?
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      flash[:danger] = '権限がありません'
      redirect_to root_path
    end
  end
end
