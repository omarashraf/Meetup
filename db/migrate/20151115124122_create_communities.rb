class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :comName
      t.text :description
      t.references :user, index: true

      t.timestamps
    end
  end
end
