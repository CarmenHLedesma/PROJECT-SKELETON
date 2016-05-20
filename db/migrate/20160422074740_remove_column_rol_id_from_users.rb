class RemoveColumnRolIdFromUsers < ActiveRecord::Migration
  def change
    remove_foreign_key :users, name: :users_rol_id_fk
  end
end
