class SessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      flash[:success] = 'ログインしました'
      redirect_back_or_to(root_path)
    else
      flash[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = 'ログアウトしました'
    redirect_to root_path
  end
end
