require "application_system_test_case"

class CheckinginsTest < ApplicationSystemTestCase
  test "new user checksin" do
    User.destroy_all

    visit signup_path

    fill_in "Email address", with: "test@ch.ch"
    fill_in "Name", with: "Test Name"
    fill_in "Password", with: "Password"

    click_on "Create User"

    assert page.has_content?("Check in")
  end

  test "new login checksin" do
    User.destroy_all
    @user1 = User.new email: "bruce@banner.com", name: "Bruce", password: "Password"
    @user1.save!

    visit login_path
    fill_in "email", with: "bruce@banner.com"
    fill_in "password", with: "Password"

    within("main", match: :first) do
      click_on "Log in"
    end

    assert page.has_content?("Check in")
  end

end
