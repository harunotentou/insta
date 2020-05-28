class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            auto_login(@user)
            flash[:success] = "ユーザーを作成しました"
            redirect_to root_path
        else
            render :new
        end
    end
    
    private

        def user_params
            params.require(:user).permit(:username,:email,:password,:password_confirmation,)
        end
end
