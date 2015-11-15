class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :community, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
