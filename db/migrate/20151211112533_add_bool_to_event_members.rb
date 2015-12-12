class AddBoolToEventMembers < ActiveRecord::Migration
  def change
    add_column :event_members, :rsvp, :boolean
  end
end
