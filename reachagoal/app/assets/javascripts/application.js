// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require private

// FUNÇÕES INICIAS

$('.withTooltip').tooltip();


function fullScreenContainer() {

	// Set Initial Screen Dimensions

	var screenWidth = $(window).width() + "px";
	var screenHeight = $(window).height() + "px";

	$(".bigAddSavings, .bigAddSavings > .background, .fullscreen").css({
		width: screenWidth,
		height: screenHeight
	});

	// Every time the window is resized...

	$(window).resize( function () {

		// Fetch Screen Dimensions

		var screenWidth = $(window).width() + "px";
		var screenHeight = $(window).height() + "px";
			
		// Set Slides to new Screen Dimensions
		
		$(".bigAddSavings, .bigAddSavings > .background, .fullscreen").css({
			width: screenWidth,
			height: screenHeight
		}); 
			
	});

}

setTimeout(function(){
  if ($('.alertWrapper').length > 0) {
    $('.alertWrapper').remove();
  }
}, 5000)

// PARALLAX
function parallaxBg(){
   // cache the window object
   $window = $(window);
 
   $('.parallax-bg[data-type="background-parallax"]').each(function(){
     // declare the variable to affect the defined data-type
     var $scroll = $(this);
                     
      $(window).scroll(function() {
        // HTML5 proves useful for helping with creating JS functions!
        // also, negative value because we're scrolling upwards                            
        var yPos = -($window.scrollTop() / $scroll.data('speed'));
         
        // background position
        var coords = '50% '+ yPos + 'px';
 
        // move the background
        $scroll.css({ backgroundPosition: coords });   
      }); // end window scroll
   });  // end section function
};

$(".filtro_obj").click(function() { 
	var estado = $(this).data('estado');
	var cat_id = $(this).data('catid');
	if (estado ==undefined){
		estado = "aaa";}
	if (cat_id == undefined){
		cat_id = "aaa";}
	loadObjectives(estado,cat_id);
});

function loadObjectives(estado,cat_id) {
	
	$.ajax({
		url: "ajax_challenges",
		data: "estado="+estado+"&catid="+cat_id,
		contentType: 'application/json; charset=utf-8',
		success: function (result) {
            $("#challenges").html(result);
        },
        error: function (err) {
            console.log("AJAX error in request: " + JSON.stringify(err, null, 2));
        }
	});
	
}


var completeBadgeWidth = $('.completedBadge .textWrapper').width();
function completeBadge() {
	$('.completedBadge .textWrapper').css({
		'height':completeBadgeWidth+'px',
		'border-radius':completeBadgeWidth+'px'
	});
};

//Run function when window resizes
$(window).resize(completeBadge);


$(document).ready(function() {
	fullScreenContainer();
	parallaxBg();
	completeBadge();
});





