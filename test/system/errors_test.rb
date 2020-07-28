require "application_system_test_case"

class ErrorsTest < ApplicationSystemTestCase
  test "404" do
    visit "/404"

    assert_text "Contenido no encontrado"
  end

  test "422" do
    visit "/422"

    assert_text "Los datos ingresados no son válidos"
  end

  test "500" do
    visit "/500"

    assert_text "Ha ocurrido un error"
  end
end
