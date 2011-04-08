$(function() {

  var map;
  var myMarker;

  function loadScript() {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src = "http://maps.google.com/maps/api/js?sensor=false&callback=initializeMap";
    document.body.appendChild(script);
  }

  loadScript();

  function initializeMap() {
    var myLatlng = new google.maps.LatLng(-34.397, 150.644);
    var myOptions = {
      zoom: 8,
      center: myLatlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById("map"), myOptions);
    if (window.myLocation) {
      setLocation(window.myLocation, window.myLat, window.myLng);
    } else {
      geolocate();
    }
    if (window.connections.length > 0) addConnections();
  }

  function geolocate() {
    var siberia = new google.maps.LatLng(60, 105);
    var newyork = new google.maps.LatLng(40.69847032728747, -73.9514422416687);
    var browserSupportFlag =  new Boolean();

    // Try W3C Geolocation (Preferred)
    var location = google.loader.ClientLocation;
    var locationName = location.address.city + ", " + location.address.region + ", " + location.address.country;
    setLocation(locationName, location.latitude, location.longitude);

    if(navigator.geolocation) {
      browserSupportFlag = true;
      navigator.geolocation.getCurrentPosition(function(position) {
        var locationName = position.address.city + ", " + position.address.region + ", " + position.address.country;
        setLocation(locationName, position.coords.latitude,position.coords.longitude);
      }, function() {
        handleNoGeolocation(browserSupportFlag);
      });
    } else {
      browserSupportFlag = false;
      handleNoGeolocation(browserSupportFlag);
    }

    function handleNoGeolocation(errorFlag) {
      var initialLocation;
      if (location) return;
      if (errorFlag == true) {
        alert("Geolocation service failed.");
        initialLocation = newyork;
      } else {
        alert("Your browser doesn't support geolocation. We've placed you in Siberia.");
        initialLocation = siberia;
      }
      map.setCenter(initialLocation);
    }
  }

  function addConnections() {
    var latlngbounds = new google.maps.LatLngBounds();
    latlngbounds.extend(myMarker.getPosition());

    for (var i=0; i<window.connections.length; ++i) {
      var connection = window.connections[i];
      var latLng = new google.maps.LatLng(connection.lat,connection.lng);
      var marker = new google.maps.Marker({
        icon: '/images/green_dot.png',
        position: latLng,
        title: connection.title + " " + connection.photo_count + " photos, " + connection.connected_to_count + " connections",
        map: map
      });

      setInfoWindow(connection.id, marker)
      latlngbounds.extend(latLng);
    }

    map.fitBounds(latlngbounds);
    setTimeout(function() { if (map.getZoom() > 8) map.setZoom(8); }, 500);
  }

  function setInfoWindow(id, marker) {
    var infowindow = new google.maps.InfoWindow({
      content: "<div class='in_map_connection'>" + $("#connection_" + id).html() + "</div>"
    });

    google.maps.event.addListener(marker, 'click', function() {
      infowindow.open(map,marker);
    });
  }

  function setLocation(name, lat, lng) {
    $("#profile_location").val(name);
    $("#profile_lat").val(lat);
    $("#profile_lng").val(lng);
    $("#location_name").html($("#profile_location").val());
    map.setCenter(new google.maps.LatLng(lat, lng));
    if (myMarker) {
      myMarker.setPosition(new google.maps.LatLng(lat,lng));
    } else {
      myMarker = new google.maps.Marker({
        icon: '/images/red_dot.png',
        position: new google.maps.LatLng(lat,lng),
        title: "This Page",
        map: map
      });
    }
    $("#edit_location").hide();
    $("#verify_location").show();
  }

  function parseGeocodeResults(results) {
    var result = results[0];
    setLocation(result.formatted_address, result.geometry.location.lat(), result.geometry.location.lng())
    $("#edit_location").hide();
    $("#edit_location #set_location").show();
    $("#edit_location .searching").hide();
  }

  function geocodeLocation(location) {
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({address: location}, parseGeocodeResults);
    $("#edit_location #set_location").hide();
    $("#edit_location .searching").show();
  }

  window.initializeMap = initializeMap;

  $("#edit_location #set_location").click(function() {
    geocodeLocation($("#revised_location").val());
  });

  $("#edit_location input").keypress(function(e) {
    if (e.keyCode == 13) geocodeLocation($(this).val());
  });
});
