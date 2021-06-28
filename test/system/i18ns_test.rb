require "application_system_test_case"

class I18nsTest < ApplicationSystemTestCase
  test "welcome page has i18n options" do
    visit home_about_path

    assert page.has_content?("Select language:")
    assert page.has_content?("en")
    assert page.has_content?("es")
    assert page.has_content?("fr")
  end

  test "try i18n on welcome pages" do
    visit home_about_path
    assert page.has_content?("Welcome")

    click_on "es"
    assert page.has_content?("Bienvenido")

    click_on "fr"
    assert page.has_content?("Bienvenu·e")

    click_on "Menu"
    click_on "Connexion"
    assert page.has_content?("Mot de passe")

    click_on "en"
    assert page.has_content?("Password")
  end

  test "log in and try i18n" do
    visit new_user_path

    click_on "fr"

    fill_in "Adresse email", with: "test@ch.ch"
    fill_in "Prénom et nom", with: "Test Name"
    fill_in "Mot de passe", with: "Password"

    click_on "Créer un(e) User"

    assert page.has_content?("Arriver")
  end
end
