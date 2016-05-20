class CreateComentarios < ActiveRecord::Migration
  def up
    create_table :comentarios do |t|
      t.integer :user_id
      t.text :texto
      t.references :comentable, polymorphic: true

      t.timestamps
    end
  end

  def down
    drop_table :comentarios
  end
end