class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user_sender, index: true
      t.belongs_to :user_receiver, index: true
      t.text :content
      t.timestamps
    end
  end
end
