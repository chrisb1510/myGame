#*****************************************************************************
#COLLECTIONS*****************************************************************
#****************************************************************************
#Had to move these as packages stopped working, moved all into main, 
#then collections stopped working 

#BOARDS**********************************************************************
@Boards = new Meteor.Collection 'myboards'
#PERMISSIONS-----------------------------        
Boards.allow
    insert: (_id, doc) ->
        return true
    update: (_id, doc, fields, modifier) ->
        return true
    remove: (_id, doc) ->
        return true
    transform: (_id,doc) ->
        new Board(doc)
    



#USERS************************************************************************
@Users = Meteor.users
#PERMISSIONS-----------------------------
Users.allow
    insert:(doc)->
        return true
    update:(doc)->
        return true
    remove:(doc)->
        return true
    transform:(doc)->
        new User(doc)

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

#PLAYERS*******************************************************************************


class @Player 
    constructor:({@_id,@number,@name}={})->
        @_id ?= Meteor.uuid()
        @typeName ?="Player"
        @number ?= "n/a"    
        @name ?= "anon"

#**************************************************************************
#EJSON definitions
#**************************************************************************

    
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
         _id        :@_id
         typeName   :@typeName
         name       :@name
         number     :@number
         }        
    #-------------------------------------------------------        
    EJSON.addType "Player",(value) ->
        console.log value
        new Player(value)          
#*******************************************************************************
#*******************************************************************************
class @Room 
    constructor:({@_id,@name,@ownerid}={})->
        @_id        ?= Meteor.uuid()
        @typeName   ?= "Room"
        @ownerid    ?= ""
        @messages    = {}

#**************************************************************************
#EJSON definitions
#**************************************************************************
    


    clone:()-> new Room(@)
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
         _id      :@_id
         typeName :@typeName
         ownerid  :@ownerid
         }        
    #-------------------------------------------------------        
    EJSON.addType "Room",(value) ->
        console.log value
        new Player(value)          


#*******************************************************************************
#CHATMESSAGE--------------------------------------------------------------------
#CHATMESSAGE--------------------------------------------------------------------
#*******************************************************************************        
class @Chatmessage 
    constructor:({@_id,@created,@owner,@message,@roomid}= {})->
        @_id      ?= Meteor.uuid()
        @typeName ?= "Chatmessage"
        @created  ?= new Date()   
        @owner    ?= "admin"
        @message  ?= "dEFAULT MESSAGE"
        @roomid   ?= "main"


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
            _id      :@_id
            typeName :@typeName
            created  :@created,
            owner    :@owner,
            message  :@message,
            roomid   :@roomid
            }        
    #-------------------------------------------------------        
    EJSON.addType "Chatmessage",(value) ->
        console.log value
        new Chatmessage(value)
#*******************************************************************************
#*******************************************************************************           
class @Profile
    constructor:({@_id,@name,@avatar,@totaltokens,
    @gameslost,@gameswon,@roomid}={})->
        @_id         ?= Meteor.uuid()
        @typeName    ?= "Profile"
        @name        ?=  "anon"
        @avatar      ?= "generic.png"
        @totaltokens ?= 0
        @gameslost   ?= 0
        @gameswon    ?= 0
        @roomid      ?= "main"

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
            _id         :@_id
            typeName    :@typeName
            name        :@name
            avatar      :@avatar
            totaltokens :@totaltokens
            gameslost   :@gameslost
            gameswon    :@gameswon
            roomid      :@roomid
        }
    #-------------------------------------------------------
    EJSON.addType "Profile",(value) ->
        console.log value
        new Profile(value)
#*******************************************************************************
#*******************************************************************************     
class @User 
    @USERCOUNT : 0

    constructor:({@_id,@username,@password,@profile}={})->
        @typeName  = "User"
        @_id      ?= Meteor.uuid()
        @username ?= "AnonUser"+ (User.USERCOUNT+=1)
        @password ?= "default"
        @profile  ?=  new Profile()  
        
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
    inserttoDB:()=>
        Accounts.createUser @
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
            _id      :@_id
            typeName :@typeName
            username :@username
            password :@password
            profile  :@profile
        }

    EJSON.addType "User",(value) ->
        console.log value
        new User(value)

#**************************************************************************
#SPACE*********************************************************************
#**************************************************************************
class @Space
    constructor:({@_id,@number,@tokens,@players}={})->
        @_id ?= Meteor.uuid()
        @typeName ?= "Space"
        #sets the space number
        if @number is 1
            @isStart = true
        @tokens ?= 0
        @players ?= []
    
    #METHODS-----------------------------------------------------
    
    @onEntry = ()->
        return
    @onexit = () ->
        return
    
    #**************************************************************************
    #EJSON definitions
    #**************************************************************************
    clone:()->
         new Space(@) 
    getTypeName:()-> return @typeName
    equals:(other)->
         if other.getTypeName() isnt @typeName 
             return false
         EJSON.stringify( @ ) == EJSON.stringify(other)
    toJSONValue:()->
         return {
            _id :       @_id
            typeName :  @typeName
            number:     @number
            players:    @players
            tokens:     @tokens
        }

    EJSON.addType "Space",(value) ->
        console.log value
        new Space(value)            

#**************************************************************************
#SPACE*********************************************************************
#**************************************************************************
class @Board
    constructor:( {@_id,@Spaces,@ownerId,@firstcorner} ={} )->
        @_id ?= Meteor.uuid()
        @typeName = "Board"
        
        @firstcorner ?= [   0,   0]
        @ownerId ?= Meteor.uuid()
        @Spaces ?= []
        numOfSpaces = 20
        for i in [0..numOfSpaces] 
            @Spaces[i]= new Space()
        
    
            
        #make spaces from class and allocate x,y of each
    
            
        
#**************************************************************************
#EJSON definitions
#**************************************************************************
    clone:()->new Board(@) 
    
    getTypeName:()-> return @typeName
    
    equals:(other)->
         if other.getTypeName() isnt @typeName 
             return false
         EJSON.stringify( @ ) == EJSON.stringify(other)
    
    toJSONValue:()->
         return {
            _id         :@_id
            typeName    :@typeName
            Spaces      :@Spaces
            numOfSpaces :@numOfSpaces
            firstcorner :@firstcorner
            profile     :@profile
        }

    EJSON.addType "Board",(value) ->
        console.log value
        new Board(value)        
             