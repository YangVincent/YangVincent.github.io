
jQuery(document).ready(function($) {
  /*======= Skillset *=======*/
  $('.level-bar-inner').css('width', '0');
  $(window).on('load', function() {
    $('.level-bar-inner').each(function() {
      var itemWidth = $(this).data('level');

      $(this).animate({
        width: itemWidth
      }, 800);
    });
  });
});
$(document).on('tap', function(event) {
  if ( $(window).width() < 767 ){
    dragging=false;
    var text = $(event.target).text().replace(/ /g, "-").replace(/!/g, "").toLowerCase();
    /* Regex replace global, otherwise replace only changes first*/
    if (text.substring(0, 3) == 'ecs' || text.substring(0, 3) == 'cou' || text.substring(0, 3) == 'top' || $(event.target).attr('class') == "choose-course" || 
        $(event.target).attr('class') == "choose-topic"){
      $('.tab-pane').fadeOut();
      setTimeout(function() {
        $('li[href!="#"]').removeClass('active');
        //$('href!="#"').removeClass('active');
      }, 200);
      setTimeout(function() {
        $('body').scrollTop(0);
        $('#'.concat(text)).fadeIn();
      }, 400);
      setTimeout(function() {
        $('#'.concat(text)).addClass('active');
      }, 600);
    }
  }
});
