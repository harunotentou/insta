class ApplicationController < ActionController::Base
    #Sorceryのrequire_loginで認証されない場合の処理（not_authenticatedというメソッドを実行するため）
    def not_authenticated
        flash[:warning]= "ログインしてください"
        redirect_to login_path
    end
end
