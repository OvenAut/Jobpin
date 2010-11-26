// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
  var infowindow = new google.maps.InfoWindow();
	var content = "";
	var maxlat = -100.0;
	var minlat = 100.0;
	var maxlng = -100.0;
	var minlng = 100.0;
	
	//leave margin each side 
	 var marginRatio = 0.00001;
	
	function gup( name )
	{
	  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
	  var regexS = "[\\?&]"+name+"=([^&#]*)";
	  var regex = new RegExp( regexS );
	  var results = regex.exec( window.location.href );
	  if( results == null )
	    return "";
	  else
	    return results[1];
	}
	
//document).ready(	
 $(function() {

	$.getScript("/javascripts/tabs.js", function() {
		
	});
	
	$('input.clear').each(function(){
		$(this)
		  .data('default',$(this).val())
		  .addClass('inactive')
		      .focus(function() {
		        $(this).removeClass('inactive');
		        if($(this).val() == $(this).data('default') || '') {
		          $(this).val('');
		        }
		      })
		      .blur(function() {
		        var default_val = $(this).data('default');
		        if($(this).val() == '') {
		          $(this).addClass('inactive');
		          $(this).val($(this).data('default'));
		        }
		      });
		  });

		

	
	
//	$.getScript("/javascripts/formhints.js", function() {
		
//	});
	
//	$("input.searchlist").ztInputHint();
	
/*		
		var latlng = new google.maps.LatLng(48.173, 16.413);
		
		
		
		    var myOptions = {
		      zoom: 8,
		      center: latlng,
		      mapTypeControl: true,
		      mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
		      mapTypeId: google.maps.MapTypeId.ROADMAP
		    };
	var MAP = new google.maps.Map(document.getElementById("map"),myOptions);
	
	*/
//alert($.url);	
//	$.getScript(this.href);
	
	//var page = $(this.href).attr("pins","lists");
	//alert($params(this.href));
//	alert(gup("pins"));
	//THIS.HREF
	var myregexp = "/pins";
	var page = window.location.pathname.replace(myregexp, "/lists");
	if (window.location.pathname.search(myregexp) >= 0)
	{
	
	}
	else
	{
		page = "/lists";
	}

	if (page== "/")
	page = "/lists"
	
	page = page + window.location.search;
//	alert(page);

	$.getJSON(page,
	  
	function(data) {
		//var data = 
//		data = data2
		
		$.each(data, function() { 
		
			if (this.pin)
			var pins = this.pin;
			else
			var pins = this;
			
			var x = pins.latitude*10000;
			x = Math.round(x) ;
			pins.latitude = x/10000;
			
			var y = pins.longitude*10000;
			y = Math.round(y) ;
			pins.longitude = y/10000;
			
	//	alert(pins.latitude + " " + maxlat);
		if (maxlat < pins.latitude) {
		maxlat = pins.latitude;
//		alert(maxlat);
		};
		
		if (minlat > pins.latitude) {
		minlat = pins.latitude;
		};
		
		if (maxlng < pins.longitude)
		maxlng = pins.longitude;
		
		if (minlng > pins.longitude)
		minlng = pins.longitude;
		
		
		});
	//	alert("maxlat" + maxlat + "MINLAT=" + minlat + "maxlng" + maxlng + "minlng=" + minlng);
		
		var midlat = (maxlat + minlat)/2;
		var midlng = (maxlng + minlng)/2;
		
		
	var latlng = new google.maps.LatLng(midlat,midlng);
	
//       	 var southWest = new google.maps.LatLng(minlat-marginRatio, minlng-marginRatio);
//	      var northEast = new google.maps.LatLng(maxlat+marginRatio, maxlng+marginRatio);

	if (minlat == maxlat)
	{
	var marginRation = 0.002;	
	}
	else
	{
	var marginRation = 0.000;	
	}
//	alert(marginRation);
	
       	 var southWest = new google.maps.LatLng(minlat-marginRation, minlng-marginRation);
	      var northEast = new google.maps.LatLng(maxlat+marginRation, maxlng+marginRation);

		  var bounds = new google.maps.LatLngBounds(southWest,northEast);

	     //  bounds.extend(maxLatLng);
	     // bounds.extend(minLatLng);      

	      
	
	
	    var myOptions = {
	      zoom: 8,
	      center: latlng,
	      mapTypeControl: true,
	      mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
	      mapTypeId: google.maps.MapTypeId.ROADMAP
	    };
		
		
		var MAP = new google.maps.Map(document.getElementById("map"),myOptions);
		MAP.fitBounds(bounds);

	//	MAP.setZoom(map.getBoundsZoomLevel(bounds));

		$.each(data, function(){
			
					if (this.pin)
					var pins = this.pin
					else
					var pins = this
					
//					alert(this.pin.title);
					var name = pins.title + " " + pins.id;
					var lat = pins.latitude;
					var lng = pins.longitude;
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
						$.getJSON("/lists/"+ pins.id,
						function(list) {
						content = '<div>Company: ' + list.pin.company + '</div>';
						content += '<div>Title: ' + list.pin.title + '</div>';
						content += '<div>Description: ' + list.pin.description + '</div>';
						content += '<div><a href="/pins/'+ list.pin.id +'" target="_parent">details</a></div>';
						infowindow.setContent(content);
						infowindow.open(MAP,marker);
						
						});
					});
					//infowindow.setContent(name);
					
		    });
	}); // getJSON /lists
	
//	$.getJSON("/lists/1",function(data){
		
//	});
	
});