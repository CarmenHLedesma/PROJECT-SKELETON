module Buscador
  extend ActiveSupport::Concern

  module ClassMethods
    def buscador(params, buscador)
      resultados = self.where(nil)

      if params[:limpiar] == 'true'
        params.delete(:buscador)
      elsif buscador.present?
         buscador.each do |key,value|
          resultados = resultados.public_send(key,value) if value.present?
        end
      end
      resultados
    end
  end

end

