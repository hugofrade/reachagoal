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

$('.withTooltip').tooltip();






function fullScreenContainer() {

	// Set Initial Screen Dimensions

	var screenWidth = $(window).width() + "px";
	var screenHeight = $(window).height() + "px";

	$(".bigAddSavings, .bigAddSavings > .background").css({
		width: screenWidth,
		height: screenHeight
	});

	// Every time the window is resized...

	$(window).resize( function () {

		// Fetch Screen Dimensions

		var screenWidth = $(window).width() + "px";
		var screenHeight = $(window).height() + "px";
			
		// Set Slides to new Screen Dimensions
		
		$(".bigAddSavings, .bigAddSavings > .background").css({
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


/* CHART */

var randomScalingFactor = function(){ return Math.round(Math.random()*100)};
var lineChartData = {
	labels : ["January","February","March","April","May","June","July"],
	datasets : [
		{
			label: "My First dataset",
			fillColor : "rgba(220,220,220,0.2)",
			strokeColor : "rgba(220,220,220,1)",
			pointColor : "rgba(220,220,220,1)",
			pointStrokeColor : "#fff",
			pointHighlightFill : "#fff",
			pointHighlightStroke : "rgba(220,220,220,1)",
			data : [randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor()]
		}
	]

}

window.onload = function(){
var ctx = document.getElementById("canvas").getContext("2d");
window.myLine = new Chart(ctx).Line(lineChartData, {
	responsive: true
});
}
