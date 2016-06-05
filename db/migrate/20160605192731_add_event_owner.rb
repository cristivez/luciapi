class AddEventOwner < ActiveRecord::Migration
  def change
    add_column :online_events, :owner , :integer
  end
end
