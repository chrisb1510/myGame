if Meteor.isClient
  Template.hello.greeting = ->
    "Welcome to My Game."

  Template.hello.events = "click #tester": ->
    alert "You pressed the button"

  
