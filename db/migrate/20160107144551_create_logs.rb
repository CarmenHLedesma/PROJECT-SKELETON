class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :usuario_id
      t.string :accion
      t.string :controller
      t.string :ip
      t.text :params

      t.timestamps
    end
  end
end
