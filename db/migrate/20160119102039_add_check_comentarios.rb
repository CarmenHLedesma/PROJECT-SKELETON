class AddCheckComentarios < ActiveRecord::Migration
  def change
    add_column :comentarios, :check, :boolean
  end
end
