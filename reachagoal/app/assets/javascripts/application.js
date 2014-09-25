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
//= require_tree


// FUNÇÕES INICIAS
$(document).ready(function() {
	fullScreenContainer();
	dashboardScroll();
	parallaxBg();
});

$('.userFriends .body a').tooltip();


// INTRO FULLSCREEN
function fullScreenContainer() {

	// Set Initial Screen Dimensions

	var screenWidth = $(window).width() + "px";
	var screenHeight = $(window).height() + "px";

	$("#intro, #intro .item").css({
		width: screenWidth,
		height: screenHeight
	});

	// Every time the window is resized...

	$(window).resize( function () {

		// Fetch Screen Dimensions

		var screenWidth = $(window).width() + "px";
		var screenHeight = $(window).height() + "px";
			
		// Set Slides to new Screen Dimensions
		
		$("#intro, #intro .item").css({
			width: screenWidth,
			height: screenHeight
		}); 
			
	});

}



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
