"use strict";

export default class Counter {

  constructor() {
    this.counter = 3;
    this.interval = null;
  }

  start() {
    var self = this;

    self.interval = setInterval(function() {
      self.tick();
    }, 1000);
  }

  tick() {
    if (this.counter <= 0) {
      clearInterval(this.interval);

      return console.log("Hello ES6!");
    }

    console.log(this.counter--);
  }
}
