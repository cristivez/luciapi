class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :phoneNumber, :string, default: ""
    add_column :users, :firstName, :string, default: ""
    add_column :users, :lastName, :string, default: ""
    add_column :users, :birthDate, :date
  end
end
