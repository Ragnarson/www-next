$(function() {
  $(".nav-link.contact").on("click", function(e) {
    e.preventDefault();

    var offset = $(".footer-contact").offset();

    $("html, body").animate({scrollTop: offset.top}, 500);
  });


  $(".footer-contact a.link-primary[onclick]").on("click", function() {
    var calendlyUrl = $(this).attr("onclick").match(/\('(.*)'\)/)[1];

    if(calendlyUrl) {
      window.ga("send", "event", "Calendly", "click", calendlyUrl);
    }
  });
});
