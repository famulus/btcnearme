// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function displayPosition(position) {
	// console.log(position.coords);
	position_global = position;
}

function displayError(positionError) {
	alert("error");
}


function initialize() {

	var latlng = new google.maps.LatLng(-34.397, 150.644);
	
	var myOptions = {
		zoom: 8,
		center: latlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	
	var map = new google.maps.Map(document.getElementById("map_canvas"),myOptions);
	
}
