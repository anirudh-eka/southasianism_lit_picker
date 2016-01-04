$(function() {

  initColorPickerInfo();

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