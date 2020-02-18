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

$(document).ready(function(){
  window.cookieconsent.initialise({
    "palette": {
      "popup": {
        "background": "#312c2c"
      },
      "button": {
        "background": "#f5f6f8"
      }
    },
    "position": "bottom",
    "content": {
      "message": "We use cookies for analytics and to improve our site. By continuing to browse the site you are agreeing to our",
      "link": "Privacy Policy.",
      "href": "https://www.iubenda.com/privacy-policy/50541107/full-legal"
    }
  });
});

$(window).scroll(function(){
  $('nav').toggleClass('scrolled', $(this).scrollTop() > 20);
});
