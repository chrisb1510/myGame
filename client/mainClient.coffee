if Meteor.isClient
#**************************************************************************
#subscriptions

    Meteor.subscribe 'chatmessages'
    Meteor.subscribe 'myusers'
    Meteor.subscribe 'myboards'
    Meteor.subscribe 'myplayers'

#HELPERS*******************************************************************
#**************************************************************************
#HELLO----------------------------------------------------------------------
    Session.setDefault "counter", 0
    Template.hello.helpers
        greeting: () ->
    	    "Welcome to My Game."
        counter: () ->
            return Session.get "counter"
    
    Template.hello.events 
        'click button': ()-> 
            # increment the counter when button is clicked
            Session.set("counter", Session.get("counter") + 1);

#USERLIST-------------------------------------------------------------------
   
    Template.Userlist.helpers
        defaultuser:()->
            user =  new User()
        Usersinsameroom:()->
            return Users.find({'profile.roomid':Session.get ('roomid') or "main"})
            
#CHATMESSAGELIST----------------------------------------------------------

    Template.Chatmessagelist.helpers
        defaultmessage:()->
            message = new Chatmessage().toJSONValue()
       
        messageslistbyroom:()->
           return Messages.find({'roomid':Session.get ('roomid') or "main"})
#GAMEBOARD---------------------------------------------------------------
    Template.GameBoard.helpers
        defaultboard:()->
            board =  new Board().toJSONValue() 
    
    Template.camera.events 
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

#CAMERA------------------------------------------------------------

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

    Template.pixicontainer.helpers
        rendered :() ->
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
            texture = PIXI.Texture.fromImage("img/bunny.png")
            # create a new Sprite using the texture
            bunny = new PIXI.Sprite(texture)
            # center the sprites anchor point
            bunny.anchor.x = 0.5
            bunny.anchor.y = 0.5
            # move the sprite t the center of the screen
            bunny.position.x = 200
            bunny.position.y = 150
            stage.addChild bunny
  
    
    Template.gyro.helpers
        rendered:()->
            @tiltListener = (LR,FB,compass) ->
                ball = document.getElementById 'tiltdisplay'
                console.log ball
                cont = document.getElementById 'gyrocontainer'
   
                viewWidth = cont.offsetWidth
                viewHeight = cont.offsetHeight
    
                if FB > 90 
                    FB =  90
                if FB < -90
                    FB = -90
                
                LR += 90
                FB += 90
    
                $("#output").html "beta : " + FB + 
                    ": gamma: " + LR + ": compass:" + compass
                
                ball.style.top  = (viewHeight*FB/180) + "px";
                ball.style.left = (viewWidth*LR/180) + "px";
                return                      

            if window.DeviceOrientationEvent?
                window.addEventListener 'deviceorientation', (eventdata) ->
                    leftRightTilt = eventdata.gamma
                    frontBackTilt = eventdata.beta
                    compassdir = eventdata.alpha
                    tiltListener leftRightTilt, frontBackTilt , compassdir
                    return
                , false
            return
                   
#METHODS*******************************************************************
#**************************************************************************

    Meteor.methods
    
        insertuser:(user)->
            Users.insert user, (err,res)->
                if err?
                    console.log "#{ err }"
                else
                    console.log res
                    return res
        #-------------------------------------------------------            
        insertchatmessage:(chatmessage)->
            Messages.insert chatmessage, (err,res)->
                if err?
                    console.log "chat insert error : #{ err }"
                else
                    console.log "Message inserted : #{res}"
                    return res
        #-------------------------------------------------------            
        insertboard:(board)->
            Boards.insert board, (err,res)->
                if err?
                    console.log "insert board error: #{ err }"
                else
                    console.log "board added #{res}"
                    return res
        #-------------------------------------------------------
        insertplayer:(player)->
            Players.insert player, (err,res)->
                if err?
                    console.log "insert player error #{ err }"
                else
                    console.log "wecome player #{res}"
                    return res
        #-------------------------------------------------------
        clear:(dbtoclear)->
            switch dbtoclear
                when "boards"       then Boards.remove({})
                when "players"      then Players.remove({})
                when "users"        then Users.remove({})
                when "chatmessages" then Message.remove({})
                when undefined then return    

    	    
    	

#**************************************************************************
#Class tests - Tests() to run

#**************************************************************************        


       
@defaultPlayer = new Player()
@defaultProfile = new Profile()
@defaultUser = new User()
        
@testProfile1= new Profile
    _id:Meteor.uuid()
    name:"testProfile1"
    avatar:"monkey.png"
    totaltokens:3
    gameswon:2
    gameslost:1
    currentroom:"main"
        
@testProfile2 = testProfile1.clone()
testProfile2.name = "testProfile2"
testProfile2.avatar = "tree.png"
testProfile2._id = Meteor.uuid()
        
console.log {testProfile1, testProfile2,defaultProfile}
        
        
@testUser1= new User
    username:"testUser1"
    password:"hello"
    profile: testProfile1
        
@testUser2 = testUser1.clone()     
        
testUser2.username = "testUser2" 
testUser2._id = Meteor.uuid()
        
console.log {testUser1,testUser2,defaultUser}
        
@defaultMessage = new Chatmessage()
@Message1 = new Chatmessage({owner:testUser1._id,message:"this test worked"})
@Message2 = new Chatmessage({owner:testUser2._id,message:"this test worked too"})
console.log {Message1,Message2,defaultMessage}


@defaultboard = new Board()
console.log @board

@inserttest = ()->
    #test inserts        
    Meteor.call "insertchatmessage", Message1, (err,res) ->
        if err?
            console.log "insert message failed :#{err}"
            false
        else
            console.log "#{res} : Inserted to Messages"
            true  
    Meteor.call "insertchatmessage", Message2, (err,res) ->
        if err?
            console.log "insert message failed :#{err}"
            false
        else
            console.log "#{res} : Inserted to Messages"
            true  
    Meteor.call "insertchatmessage", defaultMessage, (err,res) ->
        if err?
            console.log "insert message failed :#{err}"
            false
        else
            console.log "#{res} : Inserted to Messages"
            true
    
    #Test User inserts
    Meteor.call "insertuser", testUser1, (err,res) ->
        if err?
            console.log "insert user failed :#{err}"
            false
        else
            console.log "#{res} : Inserted to Users"
            true 
    Meteor.call "insertuser", testUser2, (err,res) ->
        if err?
            console.log "insert user failed :#{err}"
            false
        else
            console.log "#{res} : Inserted to Users"
            true
    Meteor.call "insertuser", defaultUser, (err,res) ->
        if err?
            console.log "insert user failed :#{err}"
            false
        else
            console.log "#{res} : Inserted to Users"
            true
    console.log "users inserted: "+Users.find().fetch()
    console.log "Messages inserted"+Messages.find().fetch()
inserttest()