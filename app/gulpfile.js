"use strict";

var elixir = require("laravel-elixir");

elixir(function(mix) {
    mix
      .rubySass("main.scss")
      .browserify("main.js")
      .version(["css/main.css", "js/bundle.js"])
    ;
});
