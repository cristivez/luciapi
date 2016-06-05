class ChangeDateFormatInMyTable < ActiveRecord::Migration
  def up
     change_column :online_events, :eventDate, :datetime
   end

   def down
     change_column :online_events, :eventDate, :date
   end
end
