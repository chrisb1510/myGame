
if Meteor.isServer
    
    Meteor.onConnection (connection)->
        user = new User()
        console.log user
        user.profile.connection = connection
        console.log user
        Accounts.createUser(user)
        user.profile.connection.onClose = ()->
            Users.remove({'profile.connection.id':@id})
        

        

    Meteor.startup ->
#*******************************************************************************
        #CLEANUP----------------------------------------
        Users.remove({})
    
        
           
#PUBLISH----------------------------------------
        
    Meteor.publish 'myusers',()->
        return Meteor.users.find({})
    Meteor.publish 'myboards',()->
        return Boards.find({})
    Meteor.publish 'myplayers',()->
        return Players.find({})
    Meteor.publish 'chatmessages',()->
        return Messages.find({})


    
#*******************************************************************************  
#METHODS************************************************************************  
#*******************************************************************************     

        
        #mpuserid = Meteor.call "insertuser", tmpuser._id,tmpuser 
    
    Meteor.methods
        #------------------------------------------------
        insertuser:(user)->

            x = Accounts.createUser user
            console.log x
            return x
        #------------------------------------------------
        insertplayer:(player)->
            Players.insert player, (err,res)->
                if err?
                    console.log "Player insert error : #{ err }"
                else
                    console.log "Player inserted : #{ res }"
                    return res
        #------------------------------------------------
        insertboard:(board)->
            Boards.insert board, (err,res)->
                if err?
                    console.log "Board insert error : #{ err }"
                else
                    console.log "Board inserted : #{ res }"
                    return res
        #------------------------------------------------
        insertchatmessage:(chatmessage)->
            Messages.insert chatmessage, (err,res)->
                if err?
                    console.log "Chatmessage insert error : #{ err }"
                else
                    console.log "Chatmessage inserted : #{ res }"
                    return res
        #CLEARDBS------------------------------------------
        clear:(dbtoclear)->
            switch dbtoclear
                when dbtoclear?     then return console.log "not found"
                when "boards"       then Boards.remove({})
                when "players"      then Players.remove({})
                when "users"        then Users.remove({})
                when "chatmessages" then Messages.remove({})
                when "all"          then do ()->
                                         Boards.remove({}) 
                                         Messages.remove({}) 
                                         Users.remove({}) 
                                         Messages.remove({})
                                         return true
                                         
                       
                   