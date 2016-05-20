module Modulos::Minutos
  include
  #funciones que pasan de fecha a minutos y de minutos a fecha.
  def self.minutos_to_date minutos
    minutos = minutos.try(:to_i)
    date = nil
    if minutos.present?
      date = DateTime.civil(0, 0, 0, minutos/60, minutos%60, 0, 0)
    end
    date
  end

  def self.date_to_minutos fecha
    if fecha.kind_of? Time
      (fecha.hour*60) + fecha.min
    else
      0
    end
  end

  def self.minutos_to_time minutos
    resto = minutos % 60
    horas = minutos / 60
    horas.to_s + I18n.t('times.horas') + ' ' + resto.to_s + I18n.t('times.minutos')
  end

end