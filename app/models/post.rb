# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  pictures   :string(255)
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
  belongs_to :user
  validates :user_id, presence: true
  validates :pictures, presence: true
  validates :content, { presence: true, length: { maximum: 1000 } }
  #テキスト型のカラムに配列を格納するために、形式をjson型にしている
  serialize :pictures, JSON
  #画像を複数枚保存するので、mount_uploaderはmount_uploadersとなる
  mount_uploaders :pictures, PictureUploader
end
