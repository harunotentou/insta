class RelationshipsController < ApplicationController
  def create
    # ajaxのためにparamsから@userを特定
    @user = User.find(params[:user_id])
    # ログインユーザーが@userをフォローする
    current_user.active_relationships.create(followed_id: params[:user_id])
    # .withでメイラーにパラメーターを渡してメール送信
    UserMailer.with(user_to: @user, user_from: current_user).follow.deliver_later
  end

  def destroy
    # ajaxのためにparamsから@userを特定
    @user = Relationship.find(params[:id]).followed
    # ログインユーザーが@userのフォローを外す
    @relationship = current_user.active_relationships.find(params[:id])
    @relationship.destroy!
  end
end
