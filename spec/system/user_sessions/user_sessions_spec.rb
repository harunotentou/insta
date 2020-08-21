require 'rails_helper'

RSpec.describe "User", type: :system do
  describe 'ログインのテスト' do
    let(:user) { create(:user) }
    context '正しいデータの場合' do
      it '成功する' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: '12345678'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
      end
    end
    
    context '正しくないデータの場合' do
      it '失敗する' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: '11111111'
        click_button 'ログイン'
        expect(page).to have_content 'ログインに失敗しました'
      end
    end
  end
  
  describe 'ログアウトのテスト' do
    let(:user) { create(:user) }
      it '成功する' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: '12345678'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        click_on('ログアウト')
        expect(page).to have_content 'ログアウトしました'
      end
  end
end