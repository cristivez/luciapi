class AddIndexToDevices < ActiveRecord::Migration
  def change
    add_index "devices", ["uuid"], name: "index_uuid", using: :btree
  end
end
