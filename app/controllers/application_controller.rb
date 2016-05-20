class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :body_literals, except: [:destroy]
  after_action :write_log, only: [ :create, :update ]

  #before_action :authenticate_user!
  #before_filter :set_current_user


  # ya no es necesario pues se va a ingresar a inicio a partir de ahora.
  #def after_sign_in_path_for(user)
  #  users_url
  #end

  # Corrección para cuando se accede a una dirección directamente por url y no hay :back
  def redirect_back_or_default( default = root_path, options = {} )
    redirect_to ( request.referer.present? ? :back : default ), options
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  #def set_current_user
  #  @current_user = current_user
  #end

  def body_literals
    # @full_width = false # variable para indentificar las vistas de los controller que deban tener el 100% del ancho de la pantalla
    # @inbox = false # variable para identificar emails-index e insertar partial de iconos
  end


  def acceso_permitido condition=true , default = root_path , options = { alert: t('no_tiene_permiso') }
    unless condition
      redirect_back_or_default default, options
    end
  end

  def write_log
    action = params[:action]
    controller = params[:controller]
    user = current_user.id
    ip = request.remote_ip

    # Log.create(attributes: {accion: action, controller: controller, usuario_id: user, ip: ip, params: params})
    #end
  end

  def user_not_authorized
    redirect_back_or_default root_path, { alert: t('no_tiene_permiso') }
    #redirect_to root_path, flash: { notice: t('permisos.denegado') }
    #flash[:alert] = "You are not authorized to perform this action."
    #redirect_to(request.referrer || root_path)
  end

end
