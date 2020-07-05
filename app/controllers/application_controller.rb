class ApplicationController < ActionController::Base
  before_action :set_search_posts_form
  add_flash_types :success, :info, :warning, :danger

  private

  # Sorceryのrequire_loginで認証されない場合の処理（not_authenticatedというメソッドを実行するため）
  def not_authenticated
    flash[:warning] = 'ログインしてください'
    redirect_to login_path
  end

   # ヘッダー部分（=共通部分）に検索フォームを置くのでApplicationControllerに実装する
  def set_search_posts_form
    @search_form = SearchPostsForm.new(search_post_params)
  end

  def search_post_params
    # .fetch(:q, {})は指定したキーがないときにエラーを出さないようにする
    params.fetch(:q, {}).permit(:content)
  end
end
