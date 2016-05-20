class Comentario < ActiveRecord::Base

  belongs_to :comentable, polymorphic: true
  belongs_to :user

end
