class CreateCommunityEvents < ActiveRecord::Migration
  def change
    create_table :community_events do |t|
      t.references :community, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
