module Modulos::DateToDbString
  #función que rescata una fecha (tipo Date o string) y lo devuelve como una fecha (string) en formato adecuado para consulta sql.
  def self.get_db_string_from_date date, format = nil
    if date.kind_of?(Date)
      date = date.to_formatted_s(:db)
    else
      if format.present?
        date =  Date.strptime( date.to_s, format.to_s ).try( :to_formatted_s, :db)
      else
        date = Date.parse( date.to_s ).try( :to_formatted_s, :db)
      end
    end
    date
  end
end