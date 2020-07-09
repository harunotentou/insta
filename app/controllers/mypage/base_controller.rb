class Mypage::BaseController < ApplicationController
  before_action :require_login
  # mypage用のviewに切り替える
  layout 'mypage'
end