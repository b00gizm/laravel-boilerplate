"use strict";

var $ = require("jquery");
var Counter = require("./counter");

$(document).ready(function() {
  console.log("DOM is ready!");

  var counter = new Counter();
  counter.start();
});
