class ComentariosController < ApplicationController
  before_action :get_comentario, only: [:destroy, :edit, :update]

  def index
    get_comentarios(params[:comentable_id], params[:comentable_type], :create)
  end

  def create
    @comentario = Comentario.create({
                                        texto: params[:comentario][:texto],
                                        comentable_id: params[:comentable_id],
                                        comentable_type: params[:comentable_type],
                                        user_id: current_user.id
                                    })
    redirect_to comentarios_path(@comentario.comentable_id.to_s, @comentario.comentable_type.to_s), format: 'js'
  end

  def edit
    get_comentarios(params[:comentable_id], params[:comentable_type], :update)
  end

  def update
    @comentario.update({
                           texto: params[:comentario][:texto],
                           user_id: current_user.id
                       })

    redirect_to comentarios_path(@comentario.comentable_id.to_s, @comentario.comentable_type.to_s), format: 'js'
  end

  def destroy
    @comentario.destroy

    # get_comentarios(@comentario.comentable_id.to_s, @comentario.comentable_type.to_s, :create)
    redirect_to comentarios_path(@comentario.comentable_id.to_s, @comentario.comentable_type.to_s), format: 'js', status: :see_other
  end

  private

  def get_comentario
    @comentario = Comentario.find(params[:id])
  end


  def get_comentarios(comentable_id, comentable_type, accion)
    @accion = accion
    @comentarios = Comentario.where(comentable_id: comentable_id, comentable_type: comentable_type)
    if @accion == :create
      @comentario = Comentario.new(comentable_id: comentable_id,comentable_type: comentable_type)
    end

    @comentarios.where('NOT `check` AND user_id != ' + current_user.id.to_s).update_all(check: true)

    respond_to do |format|
      format.js {
        render file: '/comentarios/modal_comentarios.js.erb', layout: false
      }

    end
  end
end
