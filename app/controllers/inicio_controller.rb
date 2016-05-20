class InicioController < ApplicationController

  layout "bodycontainer_layout"

  respond_to :html

  def body_literals
    super
  end

  def index
    respond_to do |format|
      format.html
    end
  end

  def get_model_for_errors
    @errors
  end

end