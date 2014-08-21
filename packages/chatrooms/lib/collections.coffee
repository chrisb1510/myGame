#collections #/lib
@Mainchatmessages = new Meteor.Collection 'chatmessages',
    transform:(doc)->
        message = _.extend new Chatmessage(),doc
        message    
@Players = new Meteor.Collection 'players',
    transform:(doc)->
        player = _.extend new Player(),doc
        player
@Rooms = new Meteor.Collection 'rooms',
    transform:(doc)->

@RoomPlayers = new Meteor.Collection 'roomplayers'

          
#player definition, coffeescript allows classes with inheritance
class @Player
    constructor:(xconnection)->
        @userId  = Random.id()
        @name = "anon"
        @ingame = false
        @currentroom = "main"
        if xconnection?
            @connection =
                id:xconnection.id
                ip:xconnection.clientAddress
                httpheaders:xconnection.httpHeaders['user-agent']


      
        
    



#-------------------------------------------------------------------
class @Room
    
    constructor:(userId) ->
        @roomId = Random.Id()
        @owner = userId
        @playersinroom = []
    	
        
    addplayer:(player)=>
    	
    playercount:()->
    	
class @Chatmessage

	constructor:() ->
		@owner="anon"
		@chatmessageid = Meteor.uuid()
		@timestamp = Date.now()
		@roomid = null
		@content = ""
	send:(error,result)=>
		if error?
			console.log error
		else
		@content = "instance function test worked"
		console.log @content

