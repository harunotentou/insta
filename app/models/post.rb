# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text(65535)      not null
#  pictures   :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  # ユーザーとの関連付け
  belongs_to :user
  # いいねとの関連付け
  has_many :likes, dependent: :destroy
  # いいねされたユーザーとの関連付け
  has_many :liked_user, through: :likes, source: :user
  # コメントとの関連付け
  has_many :comments, dependent: :destroy
  validates :pictures, presence: true
  validates :content, { presence: true, length: { maximum: 1000 } }
  # テキスト型のカラムに配列を格納するために、形式をjson型にしている
  serialize :pictures, JSON
  # 画像を複数枚保存するので、mount_uploaderはmount_uploadersとなる
  mount_uploaders :pictures, PictureUploader

  # 共通のクエリの処理を設定し、それをメソッド（()の中は引数）のように使えるようにする
  scope :content_contain, ->(word) { where('content LIKE ?', "%#{word}%") }
end
