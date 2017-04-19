class AddUserReferencesToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :user_id, :integer, references: :users
  end
end
