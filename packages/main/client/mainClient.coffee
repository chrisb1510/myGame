if Meteor.isClient
#**************************************************************************
#subscriptions

    Meteor.subscribe 'chatmessages'
    Meteor.subscribe 'myusers'
    Meteor.subscribe 'myboards'
    Meteor.subscribe 'myplayers'

#HELPERS*******************************************************************
#**************************************************************************

    Template.hello.helpers
        greeting: () ->
    	    "Welcome to My Game."
        
    Template.hello.events = { 
        "click input#tester":() ->
                console.log "You pressed the cheese"
                }	    
    
    Template.Userlist.helpers
        defaultuser:()->
            user =  new User()
        Usersinsameroom:()->
            return Users.find({'profile.roomid':Session.get ('roomid') or "main"})
            
                

            
               	
            
    Template.Chatmessagelist.helpers
        defaultmessage:()->
            message = new Chatmessage().toJSONValue()
       
        messageslistbyroom:()->
           return Messages.find({'roomid':Session.get ('roomid') or "main"})
            
    Template.GameBoard.helpers
        defaultboard:()->
            board =  new Board().toJSONValue() 
                   
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