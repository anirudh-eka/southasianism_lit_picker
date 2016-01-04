$(function() {

  initColorPickerInfo();

    $('.color-picker-canvas-container').click(function(e) {

        var posX = e.pageX - $(this).offset().left
        var posY = e.pageY - $(this).offset().top;
        
		$('.color-picker-canvas-container .sat-grad').html("<span class='color-picker-pointer'>&#9737</span>")
		$(".color-picker-pointer").css("top", posY - ($(".color-picker-pointer").height()/2));
		$(".color-picker-pointer").css("left", posX - ($(".color-picker-pointer").width()/2));
    });

});

var initColorPickerInfo = function(){
  updateColorPickerInfoContainer("welcome");

  $(".color-picker-info-container").on('click', "a", function(e){
  	e.preventDefault();
  	var partialName = $(this).attr('href').replace(/[#]/, "");	
  	updateColorPickerInfoContainer(partialName);	
  });

  function updateColorPickerInfoContainer(partialName) {
	var content = $("#color-picker-"+partialName).html();
	$('.color-picker-info-container').html(content);
  }
}