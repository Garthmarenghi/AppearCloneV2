# **Appear**
https://afternoon-citadel-01552.herokuapp.com

A fun application built with Ruby on Rails to meet up with your friends as you travel the world.

# Proposal:

## Application purpose

The concept of the application is that people will be able to easily see where in the world their friends or people in their network are, not specific addresses, but on a city/municipality level of precision. Then connect with them and initiate a conversation.

This will be useful for people that travel a lot and that have connections in many countries, to be able to easily meet up with their friends, or just to ask for advice from local connections about a specific location.

Users will also be able to see people's location history so you can ask about a place someone has visited previously.

## Front end

Anonymous users will only have access to an about page and login and sign up forms.

Users will log in and firstly be presented with a form to update their current location, then they will be redirected to the index view which will be a map with pins showing the location of their friends. It will not be possible to input an invalid location, if the location cannot be found with the GoogleMaps API and error message: "Could not find this location" will be displayed.

Clicking on the friend's pin will take them to their profile where users can see user information, including current location and past locations and distance to the friend.

There will be a button to open a 1:1 chat between the two users, this should function in real time using JavaScript, but also if one user is not logged in the message should be sent and visible to them later when they log in.

There will be a search function to find friends based on name and email address. This will have an autocomplete function.

There will be a notification system by email to inform when a new friend request arrives as well as a new message for a chat if a user does not currently have the chat window open.

Users will be able to edit their profile from their profile view, as well as see a view of their friends organised by distance to their current location. Here it will be possible to remove friends, this will update the list using JavaScript. When a user has removed a friend this person will still show up in a search result, and a new request can be made.

Users will be able to upload images to their profile for each checkin to a location. On the profile page there will be cards for each checkin, with the name of the location in the footer of the card, the body of the card will be the image that the user has uploaded for that location, or if there is no image uploaded a static .jpg map of the location (provided by the GoogleMaps API).

The app will be available in French and Spanish translations, as well as English.

_See the pdfs for a rough mockup of how the main pages will be laid out, green represents a clickable button, blue for text entry_

## Data structures and models

* **Users**
  - has_many :messages
  - has_and_belongs_to_many :friendships
  - has_many :checkins
  - belongs_to :location
  - has_secure_password
    1. First name*
    2. Last name*
    3. email address*
    4. password hash*
    5. messages
    6. location*
    7. checkins
* **CheckIns**
  - belongs_to :user
    1. timestamp
    2. location
* **Locations**
  - has_many :users
    1. address
    2. country*
    3. specific google maps location reference
    4. users at this location
* **Friendships**
  - has_and_belongs_to_many :users
  - has_many :messages
    1. Friend 1*
    2. Friend 2*
    3. messages
* **messages**
  - belongs_to :friendship
  - belongs_to :user
    1. name*
    2. body*
    3. timestamp*

## Third party services

* Gems
  - rails for framework
  - puma for the app server
  - sass-rais for SCSS stylesheets
  - uglifier to compress JavaScript assets
  - capybara and selenium-webdriver for testing
  - bcrypt for passwords
  - carrierwave for image uploads
  - fog-aws for integration with AWS
  - figaro for secure configuration of AWS
  - postgres (pg) for the production database
  - geocoder for integration with GoogleMaps
  - sendgrid-ruby for integration with SendGrid
* JavaScript libraries
  - socket.io to build the chat functionality https://socket.io/get-started/chat
* Google maps API
* Heroku for deployment
* AWS for image storage
* SendGrid for sending emails https://sendgrid.com/

# Deviations from proposal during development
* It is unnecessary and too complicated to give custom shaped markers on the dynamic map, just having an image will be enough for now.
* Dynamic map is implemented using JS
* In hindsight the **Locations** model will not be required, since it's too similar to the checkin, and we can find someone's current location just by looking at their last checkin.
* Friendships model has been replaced by the Invitations model, which logs when  friendship invitations are sent and then records confirmed:true if both users confirm the friendship.
* Didn't need to use sendgrid for the friendship notifications. This was the plain initially, so that there was a mechanism to notify users when they had a new friend request, but I built this notification system into their profile page instead so it would be redundant to also send an email.
* Added kaminari gem to handle pagination, both for users search results and checkins.

# Challenges I Faced
* I tried to implement an SVG mask to the profile pictures, which was very laborious to try to make it look like a map pin, in the end this does work well, but I wanted the profile pictures to look the same way when they are used as markers on the JS map. This isn't possible using SVG masks so I would need to find another implementation method for this.
* The current way that the message system is implemented would not work nicely if two users were online and trying to send messages to each other in real time, because the current_user must refresh the page to see new messages received. This needs improvement, there are many paid services available for this that could be used out of the box.
* There is a lot of JavaScript in views/home/index.html.erb which would ideally be in a partial, not in the .html.erb file like this, but it is not possible, as far as I can see.
* Enabling keyboard navigation for the menu without using JavaScript was problematic, after a lot of frustrating research, development, testing and refactoring to try to find a solution, I learnt that there is a preference in Mac OS that enables/disables the ability to tab through websites in Firefox and Safari. System preferences > keyboard > shortcuts > check 'use keyboard navigation to move focus between controls'.
* Implementing AWS S3 bucket was also a struggle, ultimately, I found that the problem was that by default the S3 bucket blocks all public access, this setting needs to be deactivated for this to work.

# Successes
The primary aim of this app was to have a way that people can see the locations of their friends using the GoogleMaps API and I think that this works quite well. I was able to use the API for the front end, and integrate some nice Geocoding in the back end to process the location data.

## Expansion ideas
* Add a JS map in the checkin or Edit checkin form where people can check in by dropping a pin on a map.
* Add an ignore friend request button which will dismiss the friend request without replying to it. This would involve adding a new column to the Invitation model.
* Recreate the "add_friend" partial in the invitation#update javascript view instead of the "friend request accepted" <p> element.
* Add pagination to friends list, in case someone has a huge number of friends.
* There should be an error message when a user enters a location which doesn't exist when checking in. To support this there could also be a drop down with locations options as the user starts typing.
* The 'use current location' button will create a new check in by looking at the user's IP address, but there is anther way to do this, where the app will ask the browser for the location information, the user would then see a notification from the browser, 'this website would like to use your location data' or something similar. It may be better or more accurate to use this implementation, so it would be worthwhile to look into this and see how it works and if it is different or better in some way to the current implementation.

:copyright: Fina
