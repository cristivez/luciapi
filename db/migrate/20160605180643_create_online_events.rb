class CreateOnlineEvents < ActiveRecord::Migration
  def change
    create_table :online_events do |t|
      t.string :title
      t.string :description
      t.decimal :latitude
      t.decimal :longitude
      t.date :eventDate

      t.timestamps null: false
    end
  end
end
