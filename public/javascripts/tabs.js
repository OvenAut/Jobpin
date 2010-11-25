$('#tab-content div:not(:first)').hide();
$('#tab-nav li').click(function(e){
  $('#tab-content div').hide();
  $('#tab-nav .current').removeClass('current');
  $(this).addClass('current');

  var clicked = $(this).find('a:first').attr('href');
  $('#tab-content ' + clicked).fadeIn('fast');
  e.preventDefault();
	return false;
});
//.eq(0).addClass('current');