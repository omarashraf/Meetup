class DownYobUpDmy < ActiveRecord::Migration
  def up
    remove_column :users, :year_of_birth
  end

  def down
    add_column :users, :day, :integer
    add_column :users, :month, :integer
    add_column :users, :year, :integer
  end
end
