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
    mail(to: @user.email, subject: '#{@user_from.username}があなたの投稿にいいねしました')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.comment_post.subject
  #
  def comment_post
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.follow.subject
  #
  def follow
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
