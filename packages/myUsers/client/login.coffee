Template.loginSection.events = {
  	"click #login-buttons-password" : () ->
  		alert "hi"
  	}
Template.camera.events
    'click #snapshot': () ->
        if localMediaStream
            video = document.querySelector 'video'
            canvas = document.querySelector 'canvas'
            ctx = canvas.getContext '2d'
            ctx.drawImage video, 0, 0
            document.querySelector 'img'
            .src = canvas.toDataURL 'img/webp'

if Meteor.isClient
	navigator.getUserMedia = navigator.getUserMedia or navigator.webkitGetUserMedia or navigator.mozGetUserMedia or navigator.msGetUserMedia
if navigator.getUserMedia
    navigator.getUserMedia
        video:true
    ,(@localMediaStream)->
        video = document.querySelector 'video'
        video.src = window.URL.createObjectURL @localMediaStream
        video.play
    ,(err)->
        alert "this didnt work"+err
else
    alert "getUserMedia not supported"



