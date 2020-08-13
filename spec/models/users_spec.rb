require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do 
    describe 'usernameのバリデーションのテスト' do
      context '空欄の場合' do
        it 'falseを返す' do
          user = build(:user, username: '')
          expect(user.valid?).to eq(false)
        end
      end
    end

    describe 'emailのバリデーションのテスト' do
      context 'emailが重複した場合' do
        it 'falseを返す' do
          create(:user, email: 'test0@example.com')
          other_user = build(:user, email: 'test0@example.com')
          expect(other_user.valid?).to eq(false)
        end
      end
    end
  end

  describe 'インスタンスメソッドのテスト' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    let(:post1) { create(:post, user_id: user1.id) }
    let(:post2) { create(:post, user_id: user2.id) }
    let(:post3) { create(:post, user_id: user3.id) }

    describe 'own?のテスト' do
      context '自分の投稿の場合' do
        it 'trueを返す' do
          expect(user1.own?(post1)).to eq(true)
        end
      end

      context '他人の投稿の場合' do
        it 'falseを返す' do
          expect(user1.own?(post2)).to eq(false)
        end
      end
    end

    describe 'like関係のテスト' do
      describe 'likeのテスト' do
        it 'いいねができるテスト' do
          expect{user1.like(post1)}.to change { Like.count }.by(1)
        end
      end

      describe 'unlikeのテスト' do
        it 'いいねを外すテスト' do
          user1.like(post2)
          expect{user1.unlike(post2)}.to change { Like.count }.by(-1)
        end
      end

      describe 'like?のテスト' do
        context 'いいねをした投稿の場合' do
          it 'trueを返す' do
            user1.like(post2)
            expect(user1.like?(post2)).to eq(true)
          end
        end

        context 'いいねをしていない投稿の場合' do
          it 'falseを返す' do
            expect(user1.like?(post2)).to eq(false)
          end
        end
      end
    end

    describe 'following?のテスト' do
      context 'フォローしたユーザーの場合' do
        it 'trueを返す' do
          user1.active_relationships.create(followed_id: user2.id)
          expect(user1.following?(user2)).to eq(true)
        end
      end

      context 'フォローしていないユーザーの場合' do
        it 'falseを返す' do
          expect(user1.following?(user2)).to eq(false)
        end
      end
    end

    describe 'feedのテスト' do
      context 'feedが自分の投稿とフォローしたユーザーの投稿を含む' do
        it 'trueを返す' do
          user1.active_relationships.create(followed_id: user2.id)
          expect(user1.feed).to include(post1, post2)
        end
      end

      context 'feedがフォローしていないユーザーの投稿を含まない' do
        it 'falseを返す' do
          user1.active_relationships.create(followed_id: user2.id)
          expect(user1.feed).not_to include(post3)
        end
      end
    end
  end
end