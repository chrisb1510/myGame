if Meteor.isClient
  # counter starts at 0
  Session.setDefault "counter", 0

  Template.hello.helpers =
    counter: () ->
      return Session.get "counter"
    

  Template.hello.events =
    'click button': ()-> 
      # increment the counter when button is clicked
      Session.set("counter", Session.get("counter") + 1);
  
  Template.camera.events =
    'click #snapshot': () ->
        if localMediaStream?
            video = document.querySelector 'video'
            canvas = document.querySelector 'canvas'
            canvas.width = 200
            canvas.height = 200
            canvas.display = "none"
            ctx = canvas.getContext '2d'

            ctx.drawImage video, 0, 0, 200, 200
            document.querySelector 'img'
            .src = canvas.toDataURL 'img/webp'

  navigator.getUserMedia = navigator.getUserMedia or
    navigator.webkitGetUserMedia or navigator.mozGetUserMedia or
    navigator.msGetUserMedia
    
  if navigator.getUserMedia?
    navigator.getUserMedia
      video:
        mandatory:
          maxHeight:200
          maxWidth:200
    ,(@localMediaStream)->
      video = document.querySelector 'video'
      video.src = window.URL.createObjectURL @localMediaStream
        
      video.play
    ,(err)->
      alert "this didnt work"+err
  else
    alert "getUserMedia not supported"

if Meteor.isServer
  Meteor.startup ()-> 
    # code to run on server at startup
  
