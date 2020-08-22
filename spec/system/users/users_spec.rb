require 'rails_helper'

RSpec.describe "User", type: :system do
  describe 'ユーザー登録のテスト' do
    context '正しいデータの場合' do
      it '成功する' do
        visit new_user_path
        fill_in 'ユーザー名', with: '三沢光晴'
        fill_in 'メールアドレス', with: 'misawa@yahoo.co.jp'
        fill_in 'パスワード', with: '12345678'
        fill_in 'パスワード確認', with: '12345678'
        click_button '登録'
        expect(current_path).to eq root_path
        expect(page).to have_content 'ユーザーを作成しました'
      end
    end
    
    context '正しくないデータの場合' do
      it '失敗する' do
        visit new_user_path
        fill_in 'ユーザー名', with: '三沢光晴'
        fill_in 'メールアドレス', with: 'misawa@yahoo.co.jp'
        fill_in 'パスワード', with: '87654321'
        fill_in 'パスワード確認', with: '12345678'
        click_button '登録'
        expect(page).to have_content 'ユーザーの作成に失敗しました'
      end
    end
  end    
  
  describe 'フォローのテスト' do
    let!(:userA) { create(:user) }
    let!(:userB) { create(:user) }
    context 'フォローするテスト' do
      it 'フォローできる' do
        visit login_path
        fill_in 'メールアドレス', with: userA.email
        fill_in 'パスワード', with: '12345678'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        visit posts_path
        expect {
          within "#follow-area-#{userB.id}" do
            click_link 'フォロー'
            expect(page).to have_content 'アンフォロー'
          end
      }.to change(userA.following, :count).by(1)
      end
    end
    
    context 'フォローを外すテスト' do
      it 'フォローを外せる' do
        visit login_path
        fill_in 'メールアドレス', with: userA.email
        fill_in 'パスワード', with: '12345678'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        userA.active_relationships.create(followed_id: userB.id)
        visit posts_path
        expect {
          within "#follow-area-#{userB.id}" do
            click_link 'アンフォロー'
            expect(page).to have_content 'フォロー'
          end
        }.to change(userA.following, :count).by(-1)
      end
    end
  end    
end