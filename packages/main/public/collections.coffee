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

        
#@y = Messages.findOne(x)
#console.log {y}                