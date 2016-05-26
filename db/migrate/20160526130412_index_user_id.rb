class IndexUserId < ActiveRecord::Migration
  def change
    add_column :devices, :user_id, :integer
    add_index "devices", ["uuid"], name: "index_user_id", using: :btree
  end
end
