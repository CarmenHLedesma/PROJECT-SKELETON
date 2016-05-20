class Rol < ActiveRecord::Base
  has_many :users

  def self.todos
    Rol.find_by name: 'todos'
  end

  def self.principal
    Rol.find_by name: 'principal'
  end

  def self.ninguno
    Rol.find_by name: 'ninguno'
  end

  singleton_class.send( :alias_method, :default, :principal )  # Este es el rol por defecto.
  # Si se quiere cambiar el rol por defecto, sólo hay que cambiar este alias
  # Al ser principal, zero, default, etc.. unas funciones de clase, hay que llamar al singleton_class.send( :alias_method )
    # en lugar de alias_method a pelo.


end