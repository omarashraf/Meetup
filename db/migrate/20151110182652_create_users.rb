class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :f_name
      t.text :l_name
      t.text :location
      t.integer :year_of_birth
      t.text :gender
      t.text :profile_picture
      t.timestamps
    end
  end
end
