module ApplicationHelper

  def dropdown_status
    #[[t("users.status_values.active"), :active],[t("users.status_values.locked"), :locked],[t("users.status_values.down"), :down]]
    [[t("users.status_values.active"), :active], [t("users.status_values.down"), :down]]
  end

  # Opciones para un select en el que se introducen, como id, los meses en formato bbdd y como texto, los meses en formato mes + año.
  def options_moths_for_select fecha_inicial = Date.current.advance(years: -1), fecha_final = Date.current,  format_text = t("date.formats.months"), format_id= t("date.formats.db")
    options = Array.new

    fecha_inicial ||= Date.current.advance(years: -1)
    fecha_final ||= Date.current

    #poner todos los meses a día 1
    adding_month = fecha_final.change( day: 1)

    while adding_month >= fecha_inicial do
      #añadir el mesa más viejo
      options << [ l( adding_month,  format: format_text ).capitalize, l( adding_month, format: format_id ) ]
      adding_month = adding_month.advance months: -1
    end

    options_for_select( options )
  end

  # Aplica estilos a toda la paginacion de la aplicacion
  def paginate objects, options = {}
    options.reverse_merge!( theme: 'twitter-bootstrap-3' )

    super( objects, options )
  end

  # Evalua class para span de estado de index
  def class_estado estado
    case estado
      when 0
        class_estado = 'label-default'
      when 1
        class_estado = 'label-success'
      when 2
        class_estado = 'label-danger'
      else
        class_estado = 'label-danger'
    end

    class_estado
  end

  # Evalua class para span de estado de inbox
  def class_email estado
    case estado
      when 0
        class_email = 'label-success'
      when 1
        class_email = 'label-default'
      when 2
        class_email = 'label-info'
      when 3
        class_email = 'label-primary'
      when 4
        class_email = 'label-danger'
      when 5
        class_email = 'label-warning'
      when 6
        class_email = 'label-info'
      else
        class_email = 'label-danger'
    end

    class_email
  end

  #DESPLEGAR ACCIONES
  def desplegar_accion hash
    method = hash[:metodo] || :get
    clases = hash[:clases] || ""
    link_to hash[:ruta], method: method, class: clases do
      "<i class='#{hash[:icono]}'></i>#{hash[:texto]}".html_safe
    end
  end

  # Pilla la cadena que corresponde con el id del enumerado del yml
  def take_enum string_hash_yml, enum_id
    t( string_hash_yml ).try( :[], enum_id.to_s.to_sym )
  end

  def controller?(controller)
    !(params[:action].include?"ficha_") ? (params[:controller] == controller or (params[:controller].blank? and controller="inicio")) : (params[:action].include?controller or (params[:action].blank? and controller="inicio"))
  end

  #BUSCADOR
  def buscador_field(valores,campo,buscador)
    if valores.present?
      tipo = valores.fetch( :tipo )
      case tipo
        when "select"
          buscador.select(campo, options_for_select(valores.fetch(:modelo).constantize.all.map { |elemento| [elemento.public_send(valores.fetch(:campo)), elemento.id] }, params[:buscador].try(:[],campo.to_sym)) ,{include_blank: true},{ :class => 'select-search' })
        when "select-month"
          buscador.select(campo, options_moths_for_select( valores.fetch(:fecha_inicial) ) ,{include_blank: true},{ :class => 'select-search' })
        else
          buscador.select(campo, options_for_select(t(valores.fetch(:campo)).invert, params[:buscador].try(:[],campo.to_sym)),{include_blank: true},{ :class => 'select-search' })
      end
    else
      buscador.text_field(campo, value: params[:buscador].try(:[],campo), class: 'form-control')
    end
  end

  #REDIS
  def crear_key objeto
    (objeto.class.to_s + '_' + objeto.id.to_s).to_sym
  end

end
