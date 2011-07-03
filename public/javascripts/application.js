// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function displayPosition(position) {
	// console.log(position.coords);
	position_global = position;
}

function displayError(positionError) {
	alert("error");
}


function initialize_map(position) {
console.log(position.coords.latitude);
	var latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
	
	var myOptions = {
		zoom: 14,
		center: latlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	
	var map = new google.maps.Map(document.getElementById("map_canvas"),myOptions);
	
}

function initialize(){
	
	try {
  if (typeof(navigator.geolocation) == 'undefined'){
    gl = google.gears.factory.create('beta.geolocation');
  } else {
    gl = navigator.geolocation;
  }
} catch(e) {}
 
if (gl) {
  gl.getCurrentPosition(initialize_map, displayError);
} else {
  alert("Geolocation services are not supported by your web browser.");
}

	
}