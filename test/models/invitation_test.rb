require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  test "reacted? method works" do
    user1 = User.create! email: 'johnL@test.ch',
                         password: 'password',
                         name: 'John Lennon'
    user2 = User.create! email: 'johnW@test.ch',
                         password: 'password',
                         name: 'John Wayne'
    user3 = User.create! email: 'johnT@test.ch',
                         password: 'password',
                         name: 'John Travolta'

    invitation1 = Invitation.create! user_id: user1.id, friend_id: user2.id, confirmed: false
    invitation2 = Invitation.create! user_id: user2.id, friend_id: user3.id, confirmed: true
    Checkin.create! location_name: "London, UK", user: user1
    Checkin.create! location_name: "Manchester, UK", user: user2
    Checkin.create! location_name: "Lisbon", user: user3

    assert_equal(true, Invitation.reacted?(user1, user2))
    assert_equal(false, Invitation.reacted?(user1, user3))
    assert_equal(true, Invitation.reacted?(user2, user3))
  end

  test "sent_but_no_response? method works" do
    user1 = User.create! email: 'johnL@test.ch',
                         password: 'password',
                         name: 'John Lennon'
    user2 = User.create! email: 'johnW@test.ch',
                         password: 'password',
                         name: 'John Wayne'
    user3 = User.create! email: 'johnT@test.ch',
                         password: 'password',
                         name: 'John Travolta'

    invitation1 = Invitation.create! user_id: user1.id, friend_id: user2.id, confirmed: false
    invitation2 = Invitation.create! user_id: user2.id, friend_id: user3.id, confirmed: true
    Checkin.create! location_name: "London, UK", user: user1
    Checkin.create! location_name: "Manchester, UK", user: user2
    Checkin.create! location_name: "Lisbon", user: user3

    assert_equal(true, Invitation.sent_but_no_response?(user1, user2))
    assert_equal(false, Invitation.sent_but_no_response?(user1, user3))
    assert_equal(false, Invitation.sent_but_no_response?(user2, user3))
  end

  test "confirmed_record? method works" do
    user1 = User.create! email: 'johnL@test.ch',
                         password: 'password',
                         name: 'John Lennon'
    user2 = User.create! email: 'johnW@test.ch',
                         password: 'password',
                         name: 'John Wayne'
    user3 = User.create! email: 'johnT@test.ch',
                         password: 'password',
                         name: 'John Travolta'

    invitation1 = Invitation.create! user_id: user1.id, friend_id: user2.id, confirmed: false
    invitation2 = Invitation.create! user_id: user2.id, friend_id: user3.id, confirmed: true
    Checkin.create! location_name: "London, UK", user: user1
    Checkin.create! location_name: "Manchester, UK", user: user2
    Checkin.create! location_name: "Lisbon", user: user3

    assert_equal(false, Invitation.confirmed_record?(user1, user2))
    assert_equal(Invitation.confirmed_record?(user1, user2), Invitation.confirmed_record?(user2, user1))
    assert_equal(true, Invitation.confirmed_record?(user2, user3))
    assert_equal(false, Invitation.confirmed_record?(user1, user3))
  end

  test "find_invitation method works" do
    user1 = User.create! email: 'johnL@test.ch',
                         password: 'password',
                         name: 'John Lennon'
    user2 = User.create! email: 'johnW@test.ch',
                         password: 'password',
                         name: 'John Wayne'
    user3 = User.create! email: 'johnT@test.ch',
                         password: 'password',
                         name: 'John Travolta'

    invitation1 = Invitation.create! user_id: user1.id, friend_id: user2.id, confirmed: false
    invitation2 = Invitation.create! user_id: user2.id, friend_id: user3.id, confirmed: true
    Checkin.create! location_name: "London, UK", user: user1
    Checkin.create! location_name: "Manchester, UK", user: user2
    Checkin.create! location_name: "Lisbon", user: user3

    assert_equal(invitation2.id, Invitation.find_confirmed_invitation(user2.id, user3.id))
    assert_equal(Invitation.find_confirmed_invitation(user2.id, user3.id), Invitation.find_confirmed_invitation(user3.id, user2.id))
  end

  test "find_pending method works" do
    user1 = User.create! email: 'johnL@test.ch',
                         password: 'password',
                         name: 'John Lennon'
    user2 = User.create! email: 'johnW@test.ch',
                         password: 'password',
                         name: 'John Wayne'
    user3 = User.create! email: 'johnT@test.ch',
                         password: 'password',
                         name: 'John Travolta'

    invitation1 = Invitation.create! user_id: user1.id, friend_id: user2.id, confirmed: false
    invitation2 = Invitation.create! user_id: user2.id, friend_id: user3.id, confirmed: true
    Checkin.create! location_name: "London, UK", user: user1
    Checkin.create! location_name: "Manchester, UK", user: user2
    Checkin.create! location_name: "Lisbon", user: user3

    assert_equal(invitation1.id, Invitation.find_pending(user1.id, user2.id))
  end
end
