if Meteor.isServer
    Meteor.startup ->
#*******************************************************************************
        #CLEANUP----------------------------------------
        Users.remove({})
        Meteor.users.remove({})
        
#PUBLISH----------------------------------------
        Meteor.publish 'myusers',()->
            return Users.find({})
        Meteor.publish 'myboards',()->
            return Boards.find({})
        Meteor.publish 'myplayers',()->
            return Players.find({})
        Meteor.publish 'chatmessages',()->
            return Messages.find({})

#*******************************************************************************  
#METHODS************************************************************************  
#*******************************************************************************     
    Meteor.methods
        #------------------------------------------------
        insertuser:(user)->
            Users.insert user, (err,res)->
                if err?
                    console.log "#{ err }"
                else 
                    console.log res
                    return res
        #------------------------------------------------
        insertplayer:(player)->
            Players.insert player, (err,res)->
                if err?
                    console.log "#{ err }"
                else
                    console.log res
                    return res
        #------------------------------------------------
        insertboard:(board)->
            Boards.insert board, (err,res)->
                if err?
                    console.log "#{ err }"
                else
                    console.log res
                    return res
        #------------------------------------------------
        insertchatmessage:(chatmessage)->
            Messages.insert chatmessage, (err,res)->
                if err?
                    console.log "#{ err }"
                else
                    console.log res
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
                                         
                       
                   