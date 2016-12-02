$(function() {
  $(".nav-link.contact").on("click", function(e) {
    e.preventDefault();

    var offset = $(".footer-contact").offset();

    $("html, body").animate({scrollTop: offset.top}, 500);
  });
});
