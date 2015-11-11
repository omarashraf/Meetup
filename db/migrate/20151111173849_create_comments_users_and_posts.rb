class CreateCommentsUsersAndPosts < ActiveRecord::Migration
  def change
    create_table :comments_users_and_posts do |t|
      t.belongs_to :user, index: true
      t.belongs_to :post, index: true
      t.belongs_to :comment, index: true
      t.timestamps
    end
  end
end
