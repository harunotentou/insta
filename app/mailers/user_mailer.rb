class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.like_post.subject
  #
  def like_post
    # .withで渡されたパラメータをインスタンス変数に代入
    @user_to = params[:user_to]
    @user_from = params[:user_from]
    @post = params[:post]
    # mailメソッドで宛先と題名を指定
    mail(to: @user_to.email, subject: "#{@user_from.username}があなたの投稿にいいねしました")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.comment_post.subject
  #
  def comment_post
    # .withで渡されたパラメータをインスタンス変数に代入
    @user_to = params[:user_to]
    @user_from = params[:user_from]
    @comment = params[:comment]
    # mailメソッドで宛先と題名を指定
    mail(to: @user_to.email, subject: "#{@user_from.username}があなたの投稿にコメントしました")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.follow.subject
  #
  def follow
    # .withで渡されたパラメータをインスタンス変数に代入
    @user_to = params[:user_to]
    @user_from = params[:user_from]
    # mailメソッドで宛先と題名を指定
    mail(to: @user_to.email, subject: "#{@user_from.username}があなたをフォローしました")
  end
end
