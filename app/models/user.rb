# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string(255)
#  email            :string(255)      not null
#  salt             :string(255)
#  username         :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :username, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true
  # 投稿との関連付け
  has_many :posts, dependent: :destroy
  # いいねとの関連付け
  has_many :likes, dependent: :destroy
  # いいねをした投稿と関連付け
  has_many :liked_posts, through: :likes, source: :post
  # コメントとの関連付け
  has_many :comments, dependent: :destroy
  # フォローしているユーザーとの関連付け
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  # フォローされているユーザーとの関連付け
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  def own?(object)
    id == object.user_id
  end

  def like(post)
    # ユーザーと引数で渡された投稿に紐づくいいねを作成
    likes.create(post_id: post.id)
  end

  def unlike(post)
    # ユーザーと引数で渡された投稿に紐づくいいねを削除
    likes.find_by(post_id: post.id).destroy
  end

  def like?(post)
    # ユーザーのいいねした投稿の中に、引数で渡された投稿があるかどうかを調べる
    liked_posts.include?(post)
  end
end
