// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("jquery");

import "../styles/application";

window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());

function initTwitter() {
  return window.twttr = (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0],
      t = window.twttr || {};
    if (d.getElementById(id)) return t;
    js = d.createElement(s);
    js.id = id;
    js.src = "https://platform.twitter.com/widgets.js";
    fjs.parentNode.insertBefore(js, fjs);

    t._e = [];
    t.ready = function(f) {
      t._e.push(f);
    };

    return t;
  }(document, "script", "twitter-wjs"));
}

document.addEventListener("turbolinks:load", function(event) {
  if (!window.twttr) {
    initTwitter();
  } else {
    twttr.widgets.load();
  }

  gtag('config', 'UA-162234683-2', { anonymize_ip: true, page_location: event.data.url })

  $(document).on("click", "#see-more-contents-btn", function(e) {
    e.preventDefault();
    const $button = $(e.currentTarget);
    $button.addClass("is-loading").
            attr("disabled", true);
    $.get($button.data("url"), function(resp) {
      const $page = $(resp)
      $(".contents").append($page.find(".contents").children());
      $(".see-more").replaceWith($page.find(".see-more"));
      twttr.widgets.load();
    });
  });

  $(document).ready(function() {
    $(".navbar-burger").click(function() {
      $(".navbar-burger").toggleClass("is-active");
      $(".navbar-menu").toggleClass("is-active");
    });
  });
});

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
