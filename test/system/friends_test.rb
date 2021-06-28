require "application_system_test_case"

class FriendsTest < ApplicationSystemTestCase
  test "check friendship visible" do

    user1 = User.create! email: 'johnL@test.ch',
                         password: 'password',
                         name: 'John Lennon'
    user2 = User.create! email: 'johnW@test.ch',
                         password: 'password',
                         name: 'John Wayne'
    user3 = User.create! email: 'johnT@test.ch',
                         password: 'password',
                         name: 'John Travolta'

    Invitation.create! user_id: user1.id, friend_id: user2.id, confirmed: true
    Checkin.create! location_name: "London, UK", user: user1
    Checkin.create! location_name: "Manchester, UK", user: user2
    Checkin.create! location_name: "Lisbon", user: user3

    visit login_path

    fill_in "email", with: "johnl@test.ch"
    fill_in "password", with: 'password'
    within("main", match: :first) do
      click_on "Log in"
    end

    visit account_home_path
    assert page.has_content?('John Wayne')

    click_on "John Wayne"
    assert page.has_content?("Chat")
    assert page.has_content?("Manchester, UK")
  end

  test "try accessing profile of non friend" do
    user1 = User.create! email: 'johnL@test.ch',
                         password: 'password',
                         name: 'John Lennon'
    user2 = User.create! email: 'johnW@test.ch',
                         password: 'password',
                         name: 'John Wayne'
    user3 = User.create! email: 'johnT@test.ch',
                         password: 'password',
                         name: 'John Travolta'

    Invitation.create! user_id: user1.id, friend_id: user2.id, confirmed: true
    Checkin.create! location_name: "London, UK", user: user1
    Checkin.create! location_name: "Manchester, UK", user: user2
    Checkin.create! location_name: "Lisbon", user: user3

    visit login_path

    fill_in "email", with: "johnl@test.ch"
    fill_in "password", with: 'password'
    within("main", match: :first) do
      click_on "Log in"
    end

    visit user_path(user2)
    assert page.has_content?("John Wayne")

    visit user_path(user3)
    refute page.has_content?("John Travolta")
  end

  test "search and send friend request" do
    user1 = User.create! email: 'johnL@test.ch',
                         password: 'password',
                         name: 'John Lennon'
    user2 = User.create! email: 'johnW@test.ch',
                         password: 'password',
                         name: 'John Wayne'
    user3 = User.create! email: 'johnT@test.ch',
                         password: 'password',
                         name: 'John Travolta'

    Invitation.create! user_id: user1.id, friend_id: user2.id, confirmed: true
    Checkin.create! location_name: "London, UK", user: user1
    Checkin.create! location_name: "Manchester, UK", user: user2
    Checkin.create! location_name: "Lisbon", user: user3

    visit login_path

    fill_in "email", with: "johnl@test.ch"
    fill_in "password", with: 'password'
    within("main", match: :first) do
      click_on "Log in"
    end

    visit root_path
    fill_in "q", with: "John"
    click_on 'Search', match: :first

    assert page.has_content?("John Travolta")
    click_on "Send friend request"

    assert page.has_content?("Friend Request Pending")
  end

  test "accept pending request" do
    user1 = User.create! email: 'johnL@test.ch',
                         password: 'password',
                         name: 'John Lennon'
    user2 = User.create! email: 'johnw@test.ch',
                         password: 'password',
                         name: 'John Wayne'
    user3 = User.create! email: 'johnT@test.ch',
                         password: 'password',
                         name: 'John Travolta'

    Invitation.create! user_id: user1.id, friend_id: user2.id, confirmed: false

    Checkin.create! location_name: "London, UK", user: user1
    Checkin.create! location_name: "Manchester, UK", user: user2
    Checkin.create! location_name: "Lisbon", user: user3

    visit login_path

    fill_in "email", with: "johnw@test.ch"
    fill_in "password", with: 'password'
    within("main", match: :first) do
      click_on "Log in"
    end

    visit account_home_path
    assert page.has_content?("Pending Requests")

    click_on "Accept friend request"
    assert page.has_content?("Friend Request Accepted")

    visit user_path(user1)

    assert page.has_content?("John Lennon")
  end

end
