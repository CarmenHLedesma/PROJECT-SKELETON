class AddRolUser < ActiveRecord::Migration
  def change
    add_column :users, :rol, :integer, null: false, default: 0
  end
end
