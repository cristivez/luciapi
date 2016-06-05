class AddStatus < ActiveRecord::Migration
  def change
    add_column :online_events, :status , :boolean, default: true
  end
end
