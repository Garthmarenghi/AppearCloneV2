let markers = [];
let info_windows = [];
let lastOpenedInfoWindow;

make_marker = function(friend) {
  const marker = new google.maps.Marker({
    position: {lat: friend.lat, lng: friend.lng},
    map: map,
    icon: {
      url: friend.avatar,
      scaledSize: new google.maps.Size(50, 50)
    },
    title: friend.name,
  });
  return marker;
}

make_info_window = function(friend, path_to_friend, marker) {
  const info_window = new google.maps.InfoWindow({
    content: "<h3><a href='" + path_to_friend + "'>" + friend.name + "</a></h3>",
  });

  marker.addListener("click", () => {
    lastOpenedInfoWindow.close();
    info_window.open(map, marker);
    lastOpenedInfoWindow = info_window;
  });

  return info_window;
};

initMap = function (my_location, my_avatar, my_friends, paths_to_friends, zoom_level, you_are_here_message) {

  map = new google.maps.Map(document.getElementById("map"), {
    center: my_location,
    zoom: zoom_level,
    mapId: 'e900020cdd1104fd',
  });

  if (my_avatar !== "" && my_avatar !== null) {
    var marker = new google.maps.Marker({
      position: my_location,
      icon: {
        url: my_avatar,
        scaledSize: new google.maps.Size(50, 50)
      },
      map: map
    });
  } else {
    var marker = new google.maps.Marker({
      position: my_location,
      map: map
    });
  };

  const infowindow = new google.maps.InfoWindow({
    content: you_are_here_message
  });

  infowindow.open(map, marker);
  lastOpenedInfoWindow = infowindow;

  marker.addListener("click", () => {
    lastOpenedInfoWindow.close();
    infowindow.open(map, marker);
    lastOpenedInfoWindow = infowindow;
  });

  for (i = 0; i < my_friends.length; i++) {
    markers.push(make_marker(my_friends[i]));
    info_windows.push(make_info_window(my_friends[i], paths_to_friends[i], markers[i]));
  };
};
