class PostsController < ApplicationController
  before_action :require_login, only: %i[new create edit update destroy]

  def index
    @posts = if current_user
               # ログインユーザー自身と、フォローしているユーザーの投稿
               current_user.feed.includes(:user).order(created_at: :desc).page(params[:page])
             else
               # N+1問題、ページネーションに対応
               Post.includes(:user).order(created_at: :desc).page(params[:page])
             end

    # ユーザーを登録が新しい順に５人
    @users = User.order(created_at: :desc).limit(5)
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
    # コメント表示のため
    @comments = @post.comments.includes(:user).order(created_at: :desc)
    # コメント作成フォームのため
    @comment = Comment.new
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

  def search
    @posts = @search_form.search.includes(:user).page(params[:page])
  end

  private

  def post_params
    # picturesは配列でパラメータを受け取りたい
    params.require(:post).permit(:content, pictures: [])
  end
end
