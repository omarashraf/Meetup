class AddDmyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :day, :integer
    add_column :users, :month, :integer
    add_column :users, :year, :integer
  end
end
