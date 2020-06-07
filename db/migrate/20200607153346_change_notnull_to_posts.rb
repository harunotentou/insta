class ChangeNotnullToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column_null :posts, :content, false
    change_column_null :posts, :pictures, false
  end
end
