$(function() {
  var template = $('#color-picker-welcome').html();
  // Mustache.parse(template);   // optional, speeds up future uses
  // var rendered = Mustache.render(template, {name: "Luke"});
  $('.color-picker-info-container').html(template);
});