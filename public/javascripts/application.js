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
	
	$('input.clear , textarea.clear').each(function(){
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
		
	$('#todo a').each(function(){
		$(this).click(function(){
			//$.get($(this.href),null,null,'script');
			$.getScript(this.href);
			return false;
		});
	});
		
	$('#new_todo').submit(function(){
		$.post($(this).attr("action") + ".js", $(this).serialize(), null,'script');
		//$.get(this.action, $(this).serialize(), null,'script');
		return false;
	  });
	
	// $('div#col1_content.clearfix a').click(function() {
	// 	alert($(this).attr("href") + $('input[name=address]').val());
	// 	return false;
	// });
// html body div.page_margins div.page div#main div#col1 div#col1_content.clearfix input#address
//		html body div.page_margins div.page div#main div#col1 div#col1_content.clearfix a

//	html body div.page_margins div.page div#main div#col1 div#col1_content.clearfix
	
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
	var myregexp = "/pindatas";
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


function mapstart(){
	$.getJSON(page,
	  
	function(data) {
		//var data = 
//		data = data2
		
		$.each(data, function() { 
		
			if (this.pindata)
			var pindatas = this.pindata;
			else
			var pindatas = this;
			
			var x = pindatas.lat*10000;
			x = Math.round(x) ;
			pindatas.lat = x/10000;
			
			var y = pindatas.lng*10000;
			y = Math.round(y) ;
			pindatas.lng = y/10000;
			
	//	alert(pins.latitude + " " + maxlat);
		if (maxlat < pindatas.lat) {
		maxlat = pindatas.lat;
//		alert(maxlat);
		};
		
		if (minlat > pindatas.lat) {
		minlat = pindatas.lat;
		};
		
		if (maxlng < pindatas.lng)
		maxlng = pindatas.lng;
		
		if (minlng > pindatas.lng)
		minlng = pindatas.lng;
		
		
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
	//alert(marginRation);
	
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
			
					if (this.pindata)
					var pindatas = this.pindata
					else
					var pindatas = this
					
//					alert(this.pin.title);
					var name = pindatas.company + " " + pindatas.education;
					var lat = pindatas.lat;
					var lng = pindatas.lng;
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
						$.getJSON("/lists/"+ pindatas.id,
						function(lists) {
							
							
							//alert(lists);
						content = '<div>Company: ' + lists[0].pindata.company + '</div>';
						content += '<div>Joblocation: ' + lists[0].pindata.joblocation + '</div>';
						content += '<div>Education: ' + lists[0].pindata.education + '</div>';
						content += '<div><a href="/pindatas/'+ lists[0].pindata.id +'" target="_parent">details</a></div>';
						infowindow.setContent(content);
						infowindow.open(MAP,marker);
					
						});
					});
					//infowindow.setContent(name);
					
		    });
	}); // getJSON /lists
	
//	$.getJSON("/lists/1",function(data){
	};	
//	});
	mapstart();
});