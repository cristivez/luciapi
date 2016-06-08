class Add < ActiveRecord::Migration
  def change
      add_column :devices, :pushtoken , :string
    end
end
