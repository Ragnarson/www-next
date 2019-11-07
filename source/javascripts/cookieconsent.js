window.addEventListener('load', function () {
  function initAnalytics() {
    gtag('js', new Date());
    gtag('config', 'UA-11839548-1');
  }

  window.cookieconsent.initialise({
    'palette': {
      'popup': {
        'background': '#f6f2f3'
      },
      'button': {
        'background': '#ff004f'
      }
    },
    'type': 'opt-in',
    'revokable': 'false',
    'content': {
      'message': 'We use cookies to track website impressions and to track conversions.',
      'dismiss': 'Disallow',
      'href': 'https://ragnarson.com/policy'
    },
    'law': {
      'regionalLaw': false
    },

    onInitialise: function (status) {
      if (this.hasConsented() && status == 'allow') {
        window.analyticsLoaded = true
        initAnalytics()
      }
    },

    onStatusChange: function (status, chosenBefore) {
      if (this.hasConsented() && status == 'allow' && !window.analyticsLoaded) {
        window.analyticsLoaded = true
        initAnalytics()
      }
    }
  })
});
