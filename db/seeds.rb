# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

user1 = User.create! email: 'johnL@test.ch',
                     password: 'password',
                     name: 'john lennon'
user2 = User.create! email: 'johnT@test.ch',
                     password: 'password',
                     name: 'john travolta'
user3 = User.create! email: 'johnW@test.ch',
                     password: 'password',
                     name: 'john wayne'
user4 = User.create! email: 'johnS@test.ch',
                     password: 'password',
                     name: 'st. john'

Invitation.create! user_id: user1.id, friend_id: user2.id, confirmed: true
Invitation.create! user_id: user1.id, friend_id: user3.id
Invitation.create! user_id: user3.id, friend_id: user2.id
Invitation.create! user_id: user3.id, friend_id: user4.id, confirmed: true

Checkin.create! location_name: "London, UK", user: user1
Checkin.create! location_name: "Manchester, UK", user: user1
Checkin.create! location_name: "Lausanne", user: user1


Checkin.create! location_name: "New York City", user: user2
Checkin.create! location_name: "Beijing", user: user2
Checkin.create! location_name: "Tokyo", user: user2


Checkin.create! location_name: "Shanghai", user: user3
Checkin.create! location_name: "Bangkok", user: user3
Checkin.create! location_name: "Bucharest", user: user3
Checkin.create! location_name: "Rome, Italy", user: user3


Checkin.create! location_name: "Panama", user: user4
Checkin.create! location_name: "Talin", user: user4
Checkin.create! location_name: "Amsterdam", user: user4
