class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.belongs_to :user_request_sender, index: true
      t.belongs_to :user_request_receiver, index: true
      t.boolean :accept
      t.timestamps
    end
  end
end
