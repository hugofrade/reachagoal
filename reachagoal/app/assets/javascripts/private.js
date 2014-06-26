
$(".friends_list a img")
	.mouseenter(function(){
		alert("ola");

		$(this).siblings(".nome").fadeIn(150);
	})
	.mouseleave(function(){
		$(this).siblings(".nome").fadeOut(150);
	});

