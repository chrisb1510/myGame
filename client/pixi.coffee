# CoffeeScript
if Meteor.isClient
  	Template.pixi =
  	    rendered :() ->
              mypixi()
            
    
    Template.gyro = 
        rendered:()->
            if window.DeviceOrientationEvent?
                window.addEventListener 'deviceorientation', (eventdata) ->
                    leftRightTilt = eventdata.gamma
                    frontBackTilt = eventdata.beta
                    compassdir = eventdata.alpha
                    tiltListener leftRightTilt, frontBackTilt , compassdir
                    return
                , false
            return

@tiltListener = (LR,FB,compass) ->
    
    ball = document.getElementById 'tiltdisplay'
    console.log ball
    cont = document.getElementById 'gyrocontainer'
   
    viewWidth = cont.offsetWidth
    viewHeight = cont.offsetHeight
    
    if FB >  90 
        FB =  90
    if FB < -90
        FB = -90
    LR += 90
    FB += 90
    $("#output").html "beta : " + FB + ": gamma: " + LR + ": compass" + compass
    ball.style.top  = (viewHeight*FB/180) + "px";
    ball.style.left = (viewWidth*LR/180) + "px";
                                      
@mypixi = ->

  animate = ->
    requestAnimFrame animate
    
    # change values in here
    bunny.rotation += 0.1
    
    # render the stage   
    renderer.render stage
    return
  
  stage = new PIXI.Stage(0x66FF99)
  # create a renderer instance.
  renderer = PIXI.autoDetectRenderer(400, 300)
  # add the renderer view element to the DOM
  $("#pixistage").append renderer.view
  requestAnimFrame animate
  # create a texture from an image path
  texture = PIXI.Texture.fromImage("packages/main/public/img/bunny.png")
  # create a new Sprite using the texture
  bunny = new PIXI.Sprite(texture)
  # center the sprites anchor point
  bunny.anchor.x = 0.5
  bunny.anchor.y = 0.5
  # move the sprite t the center of the screen
  bunny.position.x = 200
  bunny.position.y = 150
  stage.addChild bunny
  return