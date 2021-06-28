require "application_system_test_case"

class UserControlsTest < ApplicationSystemTestCase
  test "create user" do
    User.destroy_all

    visit signup_path

    fill_in "Email address", with: "test@ch.ch"
    fill_in "Name", with: "Test Name"
    fill_in "Password", with: "Password"

    click_on "Create User"

    refute_equal(User.all.length, 0)
    assert_equal(User.first.email, "test@ch.ch")
  end

  test "try to create invalid user" do
    User.destroy_all

    visit signup_path

    fill_in "Email address", with: ""
    fill_in "Name", with: ""
    fill_in "Password", with: ""

    click_on "Create User"

    assert page.has_content?("Name can't be blank")
    assert page.has_content?("Email can't be blank")
    assert page.has_content?("Password can't be blank")
  end

  test "try to create a duplicate user" do
    User.destroy_all

    visit signup_path

    fill_in "Email address", with: "test@ch.ch"
    fill_in "Name", with: "Test Name"
    fill_in "Password", with: "Password"

    click_on "Create User"

    visit signup_path

    fill_in "Email address", with: "test@ch.ch"
    fill_in "Name", with: "Different Name"
    fill_in "Password", with: "Password"

    click_on "Create User"

    assert page.has_content?("Email has already been taken")
  end

  test "log in does not create a User" do
    User.destroy_all
    @user1 = User.new email: "bruce@banner.com", name: "Bruce", password: "Password"
    @user1.save!

    visit login_path
    fill_in "email", with: "bruce@banner.com"
    fill_in "password", with: "Password"

    within("main", match: :first) do
      click_on "Log in"
    end

    assert_equal(1, User.all.length)
  end

  test "profile page shows checkin" do
    User.destroy_all
    @user1 = User.new email: "bruce@banner.com", name: "Bruce", password: "Password"
    @user1.save!

    @checkin1 = Checkin.new location_name: "London, UK", user: @user1
    @checkin1.save!

    visit login_path
    fill_in "email", with: "bruce@banner.com"
    fill_in "password", with: "Password"

    within("main", match: :first) do
      click_on "Log in"
    end

    visit account_home_path(:user_id => @user1.id)

    assert page.has_content?("Bruce")
    assert page.has_content?("London, UK")
  end

  test "edit and delete checkins" do
    User.destroy_all
    @user1 = User.new email: "bruce@banner.com", name: "Bruce", password: "Password"
    @user1.save!

    @checkin1 = Checkin.new location_name: "London, UK", user: @user1
    @checkin1.save!
    @checkin2 = Checkin.new location_name: "New York City", user: @user1
    @checkin2.save!

    visit login_path
    fill_in "email", with: "bruce@banner.com"
    fill_in "password", with: "Password"

    within("main", match: :first) do
      click_on "Log in"
    end
  end

end
