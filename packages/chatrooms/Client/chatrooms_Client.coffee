#client methods and subscriptions-------------------------------------------

if Meteor.isClient
	Meteor.autorun ->
        Meteor.subscribe "chatmessages"
        Meteor.subscribe "players"
        Meteor.subscribe "rooms"
        Meteor.subscribe "roomplayers"
        
        return
        #subscribe to info needed
 	Meteor.methods

 		changeroom:(roomId)->
 			Session.set("currentroom", roomId)
 		insertchat: (Chatmessage)->
            console.log "inserted"
        clearall:->
            console.log "all clear"
        clearchat: ->
            Mainchatmessages.remove({})
        clearusers:->
            Players.remove({})
        clearrooms:->
            Rooms.remove({})
        clearroomplayers:->
            RoomPlayers.remove({})
            # ...
        setUserId:(connection)->
        	Session.set "userId",userId 
    	
        

#Template helpers----------------------------------------------------------
    #pass data to the templates----------------------
	Template.chatmessages.chatmessages = ->
		Mainchatmessages.find( {}, {sort:{time:-1}})
	Template.playerouter.players = ->
		Players.find({"currentroom":"main"})
	#Template event triggers-------------------------
	Template.entry.events = 
    	'keydown input#chatText': (event) ->
        	if event.which == 13
            	chatPostMaker()
        'click input#post': ->
        	chatPostMaker()
        'click input#testing123': ->
        	room = new Room()
		'click input#clearchatbox': ->
	Template.entry.helpers
		getUserId: () ->
			# ...


			
			
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