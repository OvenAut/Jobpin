// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
  var infowindow = new google.maps.InfoWindow();
	var content = "";
	
	
	
 $(document).ready(function() {

		var latlng = new google.maps.LatLng(48.173, 16.413);
		    var myOptions = {
		      zoom: 8,
		      center: latlng,
		      mapTypeControl: true,
		      mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
		      mapTypeId: google.maps.MapTypeId.ROADMAP
		    };
	var MAP = new google.maps.Map(document.getElementById("map"),myOptions);
	$.getJSON("/lists",
	  
	function(data) {
		$.each(data, function(i,item){
					var name = data[i].pin.title + " " + data[i].pin.id;
					var lat = data[i].pin.latitude;
					var lng = data[i].pin.longitude;
		   		var point = new google.maps.LatLng(parseFloat(lat),parseFloat(lng));
					// map.bounds.extend(point);
					// add the marker itself
					var marker = new google.maps.Marker({
					    position: point,
					    map: MAP,
					    title: name,
					 });
					google.maps.event.addListener(marker, 'click', function() {
						MAP.panTo(point);
						$.getJSON("/lists/"+ data[i].pin.id,
						function(list) {
						content = '<div>Company: ' + list.pin.company + '</div>';
						content += '<div>Title: ' + list.pin.title + '</div>';
						content += '<div>Description: ' + list.pin.description + '</div>';
						infowindow.setContent(content);
						infowindow.open(MAP,marker);
						
						});
					});
					//infowindow.setContent(name);
					
		    });
	});
	$('#dropdown li ul').css({
		display: 'none',
		left:'auto'
	});

	$('#dropdown li').click(function(){
		$(this)
		.find("ul")
		.toggle()
		return false;
	});
});