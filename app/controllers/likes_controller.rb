class LikesController < ApplicationController
  before_action :require_login, only: %i[create destroy]
  def create
    # オプションで渡されたクエリパラメータから取得したparams[post_id]から投稿を特定
    @post = Post.find(params[:post_id])
    current_user.like(@post)
    if @post.user.notification_on_like
      # .withでメイラーにパラメーターを渡してメール送信
      UserMailer.with(user_to: @post.user, user_from: current_user, post: @post).like_post.deliver_later
    end
  end

  def destroy
    # params[:id]から特定された@likeから紐づく投稿を特定
    @post = Like.find(params[:id]).post
    current_user.unlike(@post)
  end
end
