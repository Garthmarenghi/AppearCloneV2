require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create and edit user" do
    User.destroy_all

    user1 = User.new email: "test@ch.ch", password: "Password", name: "Test name"
    user1.save!

    assert_equal("test name", User.all.first.name)

    user1.name = "John"
    user1.save!

    assert_equal("john", User.all.first.name)
  end
end
