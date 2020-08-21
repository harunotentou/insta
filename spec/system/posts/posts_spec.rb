require 'rails_helper'

RSpec.describe "Post", type: :system do
  describe '投稿一覧のテスト' do
    let!(:userA) { create(:user) }
    let!(:userB) { create(:user) }
    let!(:userC) { create(:user) }
    let!(:postA) { create(:post, user_id: userA.id) }
    let!(:postB) { create(:post, user_id: userB.id) }
    let!(:postC) { create(:post, user_id: userC.id) }
    
    context 'ログインしていない場合' do
      it 'すべての投稿が見られる' do
        visit posts_path
        expect(page).to have_content postA.content
        expect(page).to have_content postB.content
        expect(page).to have_content postC.content
      end
    end
    
    context 'ログインしている場合' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: userA.email
        fill_in 'パスワード', with: '12345678'
        click_button 'ログイン'
        userA.active_relationships.create(followed_id: userB.id)
      end
      it '自分とフォローしているユーザーの投稿が見られる' do
        visit posts_path
        expect(page).to have_content postA.content
        expect(page).to have_content postB.content
        expect(page).not_to have_content postC.content
      end
    end
  end
  
  describe '新規投稿のテスト' do
    let!(:user) { create(:user) }
    before do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: '12345678'
      click_button 'ログイン'
    end
    it '新規投稿できる' do
      visit new_post_path
      within '#posts_form' do
        attach_file '画像', Rails.root.join('spec', 'fixtures', 'fixture.png')
        fill_in '本文', with: 'よろしく'
        click_button '登録する'
      end
      expect(page).to have_content '投稿しました'
      expect(page).to have_content 'よろしく'
    end
  end
  
  describe '編集、削除ボタンのテスト' do
    let!(:userA) { create(:user) }
    let!(:userB) { create(:user) }
    let!(:postA) { create(:post, user_id: userA.id) }
    let!(:postB) { create(:post, user_id: userB.id) }
    before do
      visit login_path
      fill_in 'メールアドレス', with: userA.email
      fill_in 'パスワード', with: '12345678'
      click_button 'ログイン'
    end
    context '自分の投稿の場合' do
      it '編集、削除ボタンが表示される' do
        visit posts_path
        within "#post-#{postA.id}" do
          expect(page).to have_css '.delete-button'
          expect(page).to have_css '.edit-button'
        end
      end
    end
    
    context '他人の投稿の場合' do
      before do
        userA.active_relationships.create(followed_id: userB.id)
      end
      it '編集、削除ボタンが表示されない' do
        visit posts_path
        within "#post-#{postB.id}" do
          expect(page).not_to have_css '.delete-button'
          expect(page).not_to have_css '.edit-button'
        end
      end
    end
  end
  
  describe '更新、削除のテスト' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user_id: user.id) }
    before do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: '12345678'
      click_button 'ログイン'
    end
    it '削除できる' do
      visit posts_path
      within "#post-#{post.id}" do
        page.accept_confirm { find('.delete-button').click }
      end
      expect(page).to have_content '投稿を削除しました'
      expect(page).not_to have_content post.content
    end
    
    it '編集できる' do
      visit edit_post_path(post)
      within '#posts_form' do
        attach_file '画像', Rails.root.join('spec', 'fixtures', 'fixture.png')
        fill_in '本文', with: 'This is an example updated post'
        click_button '更新する'
      end
      expect(page).to have_content '投稿を更新しました'
      expect(page).to have_content 'This is an example updated post'
    end
  end
  
  describe '投稿詳細のテスト' do
    let!(:post) { create(:post) }
    it '投稿の詳細を見ることができる' do
      visit post_path(post)
      expect(page).to have_content post.content
    end
  end
  
  describe 'いいねのテスト' do
    let!(:userA) { create(:user) }
    let!(:userB) { create(:user) }
    let!(:post) { create(:post, user_id: userB.id) }
    before do
      visit login_path
      fill_in 'メールアドレス', with: userA.email
      fill_in 'パスワード', with: '12345678'
      click_button 'ログイン'
      userA.active_relationships.create(followed_id: userB.id)
    end
    it 'いいねできる' do
      visit posts_path
      expect {
        within "#post-#{post.id}" do
          find('.like-button').click
          expect(page).to have_css '.unlike-button'
        end
      }.to change(userA.liked_posts, :count).by(1)
    end
    
    it 'いいねを外せる' do
      userA.like(post)
      visit posts_path
      expect {
        within "#post-#{post.id}" do
          find('.unlike-button').click
          expect(page).to have_css '.like-button'
        end
      }.to change(userA.liked_posts, :count).by(-1)
    end
  end
end