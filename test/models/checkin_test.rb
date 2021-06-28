require 'test_helper'

class CheckinTest < ActiveSupport::TestCase
  test "new checkin" do
    User.destroy_all
    Checkin.destroy_all

    user1 = User.new email: "test@ch.ch", password: "Password", name: "test name"
    checkin1 = Checkin.new location_name: "London", user: user1

    user1.save!
    checkin1.save!

    assert_equal("test name", User.all.first.name)
    assert_equal(user1, Checkin.all.first.user)
    assert_equal("London", Checkin.all.first.location_name)
    refute_equal(Checkin.all.first.latitude, "")
    refute_equal(Checkin.all.first.latitude, nil)
    refute_equal(Checkin.all.first.longitude, "")
    refute_equal(Checkin.all.first.latitude, nil)
  end

  test "edit user name, updates related checkin" do
    User.destroy_all
    Checkin.destroy_all

    user1 = User.new email: "test@ch.ch", password: "Password", name: "Test name"
    checkin1 = Checkin.new location_name: "London", user: user1

    user1.save!
    checkin1.save!

    assert_equal("test name", User.all.first.name)
    assert_equal(user1, Checkin.all.first.user)
    assert_equal("London", Checkin.all.first.location_name)

    user1.name = "new different name"
    user1.save!

    assert_equal("new different name", user1.name)
    assert_equal(user1.name, Checkin.all.first.user.name)
  end

  test "multiple checkins in created_at date doesn't change when edited" do
    User.destroy_all
    Checkin.destroy_all

    user1 = User.new email: "test@ch.ch", password: "Password", name: "Test name"
    checkin1 = Checkin.new location_name: "London", user: user1
    checkin2 = Checkin.new location_name: "Seattle", user: user1
    checkin3 = Checkin.new location_name: "Paris", user: user1

    user1.save!
    checkin1.save!
    checkin2.save!
    checkin3.save!

    checkin1.location_name = "London, USA"
    checkin1.save!

    assert(checkin2.created_at > checkin1.created_at)
    assert(checkin3.created_at > checkin1.created_at)
  end
end
