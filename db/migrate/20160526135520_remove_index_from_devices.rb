class RemoveIndexFromDevices < ActiveRecord::Migration
  def change
    remove_index :devices, name: "index_user_id"
  end
end
