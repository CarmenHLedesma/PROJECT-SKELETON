class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum rol: { becario: 0, super_admin: 1, no_logeado: -1, admin: 2}
  #before_save :create_initial_accesibilidad



  has_many :comentarios

  attr_accessor :login , :status

  scope :becarios, -> { where(rol: roles[:becario])}
  scope :activos, -> { where(deleted_at: nil) }

  validates :username,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            }
  validates :email,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            }

  # si el deleted_at está presente, el status es :down.
  # si el deleted_at es nulo, el status es :activo.
  def active?
    deleted_at.blank?
  end

  def down?
    deleted_at.present?
  end

  # soft delete action
  def soft_delete!
    update_attributes( deleted_at: Time.current )
  end

  def soft_delete
    assign_attributes( deleted_at: Time.current )
  end

  # reactivate action
  def reactivate!
    update_attributes( deleted_at: nil )
  end

  def reactivate
    assign_attributes( deleted_at: nil )
  end


  # función para crear los permisos
  def build_or_modify_initial_accesibilidad

    if self.rol.present?
      rol = self.rol
    else
      rol = User.roles[:no_logeado]
      self.rol = rol
    end


  end

  def create_or_modify_initial_accesibilidad
    build_or_modify_initial_accesibilidad
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete( :login )
      where( conditions.to_h ).where( [ "lower(username) = :value", { :value => login.downcase } ] ).first
    else
      where( conditions.to_h ).first
    end
  end

  def no_cliente(atributos)
    atributos[:cliente_id].blank?
  end

  protected

  # Se llama sólo con la creación. Está en el after_save
  def create_initial_accesibilidad
    if self.rol.blank?
      create_or_modify_initial_accesibilidad
    end
  end

end
