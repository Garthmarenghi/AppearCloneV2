//function that will delete the "send friend request button"
removeSendFRButton = function(userId) {
  document.getElementById("add_form-" + userId).remove();
};

//function that will create the "friend request pending dom elements"
addFRPendingP = function(userId, fr_pending_message) {
  var content = document.createElement('p');
  content.className = "btn btn--unclickable";
  content.appendChild(document.createTextNode(fr_pending_message));
  document.getElementById("add_buttons_for-" + userId).appendChild(content);
};
// functions to remove accept and reject buttons
removeAcceptButton = function(userId) {
  document.getElementById("accept_form-" + userId).remove();
};
removeRejectButton = function(userId) {
  document.getElementById("reject_form-" + userId).remove();
};

addFRAcceptedP = function(userId, fr_accepted_message) {
  var content = document.createElement('p');
  content.className = "btn btn--unclickable";
  content.appendChild(document.createTextNode(fr_accepted_message));
  document.getElementById("add_buttons_for-" + userId).appendChild(content);
};
