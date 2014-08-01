Mainchatmessages = new Meteor.Collection 'mainchatmessages'
@Players = new Meteor.Collection 'players'
@Rooms = new Meteor.Collection 'rooms'
@RoomPlayers = new Meteor.Collection 'roomplayers'
#collections, @ makes globals in coffeescript, accessible in console, 
#otherwise restricted to internal.

if Meteor.isServer
	#publish the collections as above. This lets users see the collections
	#should be only published to server

	Meteor.publish "mainchatmessages", ->
        Mainchatmessages.find({})
    Meteor.publish "players", ->
    	Players.find({})
    Meteor.publish "rooms", ->
    	Rooms.find({})
    Meteor.publish "roomplayers", ->
    	RoomPlayers.find({})
    

#server methods can be called from client-----------------
    Meteor.methods
    	updatechat: (chatmessage) ->
            Mainchatmessages.insert chatmessage  
    	newRoom:(room)->
    		Rooms.insert({"Room":room})
    		#console.log ownedby
    		#roomowner = Players.findOne({playerid: ownedby})
    		#console.log @connection
    		#console.log roomowner
    		
    	addaplayer:(newplayer)->
    		tmp = newplayer
    		console.log @connection
    		tmp.connection = @connection
    		 
    	moveplayertoroom:(player,room)->
    		RoomPlayers.insert({player:player.playerid,roomid:room.roomid})
    		player.ingame = true
    	
#resets-------------------
    	clearchat: ->
    		Mainchatmessages.remove({})
    	clearusers:->
    		Players.remove({})
    	clearrooms:->
    		Rooms.remove({})
    	clearroomplayers:->
    		RoomPlayers.remove({})
    	clearall:->
    		Mainchatmessages.remove({})
    		Players.remove({})
    		Rooms.remove({})
    		RoomPlayers.remove({})
#when anyone connects this is triggered, could be useful for anonymous users, 
#no onDisconnect though, sign in only may be the only route 
    
    Meteor.onConnection (connection)->
    	newplayer = new Player connection
    	console.log newplayer
    	Players.insert({"Player":newplayer})
    	console.log connection


#--------------------------------------------------------------------    	 
#player definition, coffeescript allows classes with inheritance
class @Player
    
    constructor:(@connection) ->
        @playerid = Meteor.uuid()
        @name = "anon"
        @ingame = false
        @currentroom = null
        
        
    createroom: =>
    	room = new Room(@playerid)
    	@currentroom = room.roomid
    	Meteor.call "newRoom", room 	
    invited: =>
        if @ingame is true
                console.log "already playing"
        else 
            @ingame = true
    
#-------------------------------------------------------------------
class @Room
    
    constructor:(@owner = "anon") ->
        @roomid = Meteor.uuid()
        
    addplayer:(player)=>
    	
    playercount:()->
    	

#client methods and subscriptions-------------------------------------------

if Meteor.isClient
	Meteor.autorun ->
        Meteor.subscribe "mainchatmessages"
        Meteor.subscribe "players"
        Meteor.subscribe "rooms"
        Meteor.subscribe "roomplayers"
        return
        #subscribe to info needed
        

#Template helpers----------------------------------------------------------
    #pass data to the templates----------------------
	Template.chatmessages.mainchatmessages = ->
		Mainchatmessages.find( {}, {sort:{time:-1}})
	Template.userList.userslist = ->
		Players.find({})
	#Template event triggers-------------------------
	Template.entry.events = 
    	'keydown input#chatText': (event) ->
        	if event.which == 13
            	chatPostMaker()
        'click input#post': ->
        	chatPostMaker()
		
#misc methods and workings -------------------------------------------------
chatPostMaker = ->
	if Meteor.user()
        user = Meteor.user()
        name = user.username
        if !name?
        	namebox = $('#name').val()
        	if namebox isnt ""
        		name = namebox
        	else
                name = 'anon'
        else
        	namebox = $('#name').val()
        	if namebox isnt ""
        		name = namebox
        	else
                name = 'anon'	
        Mainchatmessage = $('#chatText').val() 
        if Mainchatmessage != ''
           	chatmessage = 
               	name: name,
               	chatPosted: Mainchatmessage,
               	created: new Date()
           	Meteor.call "updatechat",chatmessage
           	$('#chatText').val("")
           	Mainchatmessage = ''