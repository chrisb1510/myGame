#*****************************************************************************
#COLLECTIONS*****************************************************************
#****************************************************************************

#BOARDS**********************************************************************
@Boards = new Meteor.Collection 'myboards',   
    transform:(doc)->
        new Board(doc)

#PERMISSIONS-----------------------------
Boards.allow
    insert:(doc)->
        return true
    update:(doc)->
        return true
    remove:(doc)->
        return true

#USERS************************************************************************
@Users = new Meteor.Collection 'myusers',
    transform:(doc)->
        new User(doc)

#PERMISSIONS-----------------------------
Users.allow
    insert:(doc)->
        return true
    update:(doc)->
        return true
    remove:(doc)->
        return true

#MESSAGES*********************************************************************
@Messages = new Meteor.Collection 'chatmessages',
    transform:(doc)->
         new Chatmessage(doc)

#PERMISSIONS-----------------------------
Messages.allow
    insert:(doc)->
        return true
    update:(doc)->
        return true
    remove:(doc)->
        return true

#PLAYERS**********************************************************************
@Players = new Meteor.Collection 'myplayers',
    transform:(doc)->
         new Player(doc)         

#PERMISSIONS-----------------------------
Players.allow
    insert:()->
        return true
    update:()->
        return true
    remove:()->
        return true               

#*******************************************************************************
#CLASS DEFINITIONS**************************************************************
#CLASS DEFINITIONS**************************************************************
#*******************************************************************************

class @Player 
    constructor:({@number,@name}={})->
        @typeName ?="Player"
        @number ?= "n/a"    
        @name ?= "anon"
    
    clone:()-> new Player(@)
    #------------------------------------------------------- 
    getTypeName:()-> return @typeName
    
    #-------------------------------------------------------
    equals:(other)->
         if other.getTypeName() isnt @typeName 
             return false
         EJSON.stringify( @ ) == EJSON.stringify(other)
    #-------------------------------------------------------
    toJSONValue:()->
         return {
         _id:@_id
         typeName:@typeName
         name:@name
         number:@number}        
    #-------------------------------------------------------        
    EJSON.addType "Player",(value) ->
        console.log value
        new Player(value)          
#*******************************************************************************
#*******************************************************************************        
class @Chatmessage 
    constructor:({@created,@owner,@message,@room}= {})->
        @typeName ?= "Chatmessage"
        @created ?= new Date()   
        @owner ?= "admin"
        @message ?= "dEFAULT MESSAGE"
        @room ?= "main"


#**************************************************************************
#EJSON definitions
#**************************************************************************
    
    clone:()-> new Chatmessage(@) 
    #-------------------------------------------------------
    getTypeName:()-> return @typeName
    
    #-------------------------------------------------------
    equals:(other)->
         if other.getTypeName() isnt @typeName 
             return false
         EJSON.stringify( @ ) == EJSON.stringify(other)
    #-------------------------------------------------------
    toJSONValue:()->
        return {
            _id:@_id
            typeName:@typeName
            created:@created,
            owner:@owner,
            message:@message}        
    #-------------------------------------------------------        
    EJSON.addType "Chatmessage",(value) ->
        console.log value
        new Chatmessage(value)
#*******************************************************************************
#*******************************************************************************           
class @Profile
    constructor:({@name,@avatar,@totaltokens,
    @gameslost,@gameswon,@currentroom}={})->
        @typeName ?= "Profile"
        @name ?=  "anon"
        @avatar = "generic.png"
        @totaltokens ?= 0
        @gameslost ?= 0
        @gameswon ?= 0
        @currentroom ?= "main"
#**************************************************************************
#EJSON definitions
#**************************************************************************
    
    clone:()-> new Profile(@) 
    #-------------------------------------------------------
    getTypeName:()-> return @typeName
    
    #-------------------------------------------------------
    equals:(other)->
         if other.getTypeName() isnt @typeName 
             return false
         EJSON.stringify( @ ) == EJSON.stringify(other)
    #-------------------------------------------------------
    toJSONValue:()->
         return { 
            typeName:@typeName
            name:@name
            avatar:@avatar
            totaltokens:@totaltokens
            gameslost:@gameslost
            gameswon:@gameswon
            currentroom:@currentroom}
    #-------------------------------------------------------
    EJSON.addType "Profile",(value) ->
        console.log value
        new Profile(value)
#*******************************************************************************
#*******************************************************************************     
class @User 
    constructor:({@_id,@username,@password,@profile}={})->
        @typeName = "User"
        @_id ?= null
        
        @username ?= 1
        @password ?= "default"
        @profile ?=  new Profile()  
        
    changeName: (newName) ->
        @profile.name = newName
        console.log "Hello"+ @profile.name
    addTokens:(number)->
        @profile.totaltokens += number
        console.log "you now have "+ @profile.totaltokens  
    getGamestats:(which)->
        switch which
          when "both" then console.log "wins: #{ @profile.gameswon }, losses #{ @profile.gameslost }"
          when "won" then  console.log "won" +@profile.gameswon
          when "lost" then console.log "lost"+@profile.gameslost 
#**************************************************************************
#EJSON definitions
#**************************************************************************
    clone:()->
         new User(@) 
    getTypeName:()-> return @typeName
    equals:(other)->
         if other.getTypeName() isnt @typeName 
             return false
         EJSON.stringify( @ ) == EJSON.stringify(other)
    toJSONValue:()->
         return {
            typeName :@typeName
            username:@username
            password:@password
            profile:@profile}

    EJSON.addType "User",(value) ->
        console.log value
        new User(value)
#**************************************************************************
#Client - to move soon

#**************************************************************************
if Meteor.isClient
#**************************************************************************
#subscriptions
    Meteor.subscribe 'chatmessages'
    Meteor.subscribe 'myusers'
    Meteor.subscribe 'myboards'
    Meteor.subscribe 'myplayers'

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
                when "boards" then Boards.remove({})
                when "players" then Players.remove({})
                when "users" then Users.remove({})
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
    _id:Meteor.uuid()
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
        
Meteor.call "insertchatmessage", Message1, (err,res) ->
        if err?
            console.log "insert failed :#{err}"
        else
            console.log res
            return x =res
        
#@y = Messages.findOne(x)
#console.log {y}                