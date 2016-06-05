class CreateOnlineEventGuests < ActiveRecord::Migration
  def change
    create_table :online_event_guests do |t|
      t.string :phoneNumber
      t.integer :oid

      t.timestamps null: false
    end
  end
end
