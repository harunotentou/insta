class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :post, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
    # DB側にユニーク制約を忘れていたので作り直し
    add_index :likes, [:post_id, :user_id], unique: true
  end
end
