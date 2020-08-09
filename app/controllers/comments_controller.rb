class CommentsController < ApplicationController
  before_action :require_login, only: %i[create edit update destroy]
  def create
    # ログインしているユーザーに紐づけたコメントを作成
    @comment = current_user.comments.build(comment_params)
    @comment.save
    if @comment.post.user.notification_on_comment
      # .withでメイラーにパラメーターを渡してメール送信
      UserMailer.with(user_to: @comment.post.user, user_from: current_user, comment: @comment).comment_post.deliver_later
    end
  end

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def update
    @comment = current_user.comments.find(params[:id])
    @comment.update(comment_update_params)
  end

  def destroy
    # params[:id]でコメントを検索して消去
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    # params[:comment][:body]と、クエリパラメータのparams[:post_id]を結合
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end

  def comment_update_params
    # params[:comment][:body]のみ受け取る
    params.require(:comment).permit(:body)
  end
end
