(function() {
  if (Meteor.isClient) {
    Template.hello.greeting = function() {
      return "Welcome to My Game.";
    };
    Template.hello.events = {
      "click input": function() {
        return alert("You pressed the button");
      }
    };
  }

  if (Meteor.isServer) {
    Meteor.startup(function() {});
  }

}).call(this);
