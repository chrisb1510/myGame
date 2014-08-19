

if Meteor.isServer
    Meteor.startup () ->
        Players.remove({})
    #publish the collections as above. This lets users see the collecti    #should be only published to server
    Meteor.onConnection (connection)->
        x = addplayer(connection)
        @userId = x
        connection.onClose ->
            removeplayer(connection)

    Meteor.publish "chatmessages", ->
        Mainchatmessages.find({})
    Meteor.publish "players", ->
        Players.find({})
    Meteor.publish "rooms", ->
        Rooms.find({})
    Meteor.publish "roomplayers", ->
        RoomPlayers.find({})
    
    Meteor.methods
        insertchat: (Chatmessage)->
            Mainchatmessages.insert Chatmessage
        clearall:->
            Mainchatmessages.remove({})
            Players.remove({})
            Rooms.remove({})
            RoomPlayers.remove({})
        clearchat: ->
            Mainchatmessages.remove({})
        clearusers:->
            Players.remove({})
        clearrooms:->
            Rooms.remove({})
        clearroomplayers:->
            RoomPlayers.remove({})
            # ...
        createaroom:(player)->
            if Rooms.find({"room.owner":player.userId}).count() is 0
                Rooms.insert new Room(player.userId)
        setUserId: (userId)->
            @.setUserId userId 
   



            
addplayer = (connection)->
    player = new Player(connection)
    Players.insert player, (err,userId)->
        if userId?
            console.log ""+Players.find().count()+":"+userId
            return userId

    
removeplayer = (connection) ->
    Players.remove({"connection.id":connection.id})
    console.log connection.id
    console.log Players.find().count()
    




        
        
        

