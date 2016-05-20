class UsersController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_filter :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_form_index, only: :index
  before_action :set_form_new, only: :new
  before_action :set_form_edit, only: :edit
  before_action :set_form_show, only: :show
  respond_to :html, :json
  layout "bodycontainer_layout"
  def index
    authorize User
    @users = User.all
    respond_with(@users)
  end

  def show
    authorize @user
    respond_with(@users)
  end

  def edit
    authorize User
    @clientes_asignables=Cliente.activos
  end

  def update
    authorize @user
    @user.update(user_params)
    if @save_result = @user.save
      mensaje = User.model_name.human + ' ' + t('acciones.actualizado')
      redirect_to users_path, flash: { notice: mensaje }
    else
      respond_with(@user)
    end
  end
  def get_model_for_errors
    @user if @save_result == false
  end

  private
  def body_literals
    super
    model_name = t('activerecord.models.users.one')
    @current = (params[:action] == "index") ? t('activerecord.models.users.other').downcase : model_name
    @current_pl = t('activerecord.models.users.other')
    @current_path = @current_path
  end

  def set_form_index
    @accion = t('acciones.listado')
  end

  def set_form_new
    @accion = t('acciones.nuevo')
  end

  def set_form_edit
    @accion = t('acciones.editar')
  end

  def set_form_show
    @title = t('acciones.datos')
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :rol, users_clientes_attributes: [:id, :cliente_id, :user_id, :_destroy])
  end



end