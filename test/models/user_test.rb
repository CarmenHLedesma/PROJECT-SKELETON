require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:right)
  end

  should belong_to :rol
  should have_one :accesibilidad
  should have_one :empleado
  should have_one :imputacion_actividad
  should have_many :comentarios

end
