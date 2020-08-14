require 'rails_helper'
RSpec.describe Post, type: :model do
  describe 'バリデーションのテスト' do 
    describe 'picturesのバリデーションのテスト' do
      context '空欄の場合' do
        it 'falseを返す' do
          post = build(:post, pictures: '')
          expect(post.valid?).to eq(false)
        end
      end
    end

    describe 'contentのバリデーションのテスト' do
      context '空欄の場合' do
        it 'falseを返す' do
          post = build(:post, content: '')
          expect(post.valid?).to eq(false)
        end
      end
      
      context '千文字を超える場合' do
        it 'falseを返す' do
          post = build(:post, content: "#{"a" * 1001}")
          expect(post.valid?).to eq(false)
        end
      end
    end
  end

  describe 'scopeのテスト' do
    context '指定したワードを含む場合' do
      it 'trueを返す' do
        post = create(:post, content: 'おはよう')
        expect(Post.content_contain('おはよう')).to include(post)
      end
    end
    
    context '指定したワードを含まない場合' do
      it 'trueを返す' do
        post = create(:post, content: 'こんにちは')
        expect(Post.content_contain('おはよう')).not_to include(post)
      end
    end
  end
end