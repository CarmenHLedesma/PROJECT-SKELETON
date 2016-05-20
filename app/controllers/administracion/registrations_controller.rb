class Administracion::RegistrationsController < Devise::RegistrationsController

  skip_before_filter :require_no_authentication
  before_filter :require_authentication
  before_action :set_form_new, only: :new
  layout "bodycontainer_layout"

  def new
    #super
    @user= User.new
    respond_with(@user)
  end

  def create
    #super
    @user = User.new( sign_up_params )

    if @save_result = @user.save
      clean_up_passwords resource
      set_minimum_password_length
      mensaje = User.model_name.human + ' ' + t('acciones.creado')
      redirect_to users_path, flash: { notice: mensaje }
    else
      respond_with(@user)
    end
 end


  # Se coge el id del params[ :format ] para poder aprovechar estos controladores
  # (que en principio sólo modifica el del usuario que está conectado) y no tener
  # que duplicarlos en el userController.
  def edit
    super
  end

  def update
    @user = User.find params[:user][:id]

    # no se puede actualizar el id
    params[:user].delete :id

    prev_unconfirmed_email = @user.unconfirmed_email if @user.respond_to?(:unconfirmed_email)

    if params[:status] == 'active'
      @user.reactivate
    elsif params[:status] == 'down'
      # sólo se va a permitir dar de baja a otros, no a uno mismo
      if @user != current_user
        @user.soft_delete
      else
        if is_flashing_format?
          set_flash_message :alert, :cannot_destroy_yourself
        end
        redirect_to edit_user_registration_path @user
        return
      end
    end

    if params[:user][:password].present?
      @user.assign_attributes( params[:user].permit( :username , :email , :password, :password_confirmation ) )
      @user.valid?
    else
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?

      @user.assign_attributes( params[:user].permit( :username , :email ) )
    end

    resource_updated = @user.save

    yield @user if block_given?

    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(@user, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      redirect_to users_path
    else
      clean_up_passwords @user
      @status = @user.active? ? :active : :down
      render :edit
    end
  end

  # DELETE /resource
  # for soft_delete
  def destroy
    @user = User.find( params[:format] )

    if @user != current_user
      relaciones = UserCliente.where(:user_id => @user.id)
      relaciones.each{|r| r.destroy} if relaciones
      @user.soft_delete!
      yield @user if block_given?

      set_flash_message :notice, :updated
      redirect_to users_path

    else
      set_flash_message :alert, :cannot_destroy_yourself
      redirect_to :back
    end

  end

  # REACTIVATE
  # anti - soft-delete
  def reactivate
    @user = User.find( params[:id] )

    @user.reactivate!
    yield @user if block_given?

    set_flash_message :notice, :updated
    redirect_to users_path
  end

  def require_authentication
    if !user_signed_in?
      redirect_to new_user_session_path
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
    @current_path = users_path
  end

  def set_form_new
    @accion = t('acciones.nuevo')
  end

end