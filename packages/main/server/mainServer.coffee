if Meteor.isServer
    Meteor.startup ->
        Users.remove({})
        Meteor.users.remove({})
    Meteor.publish 'myusers', ->
        return Users.find({}); 
    
    
    Meteor.methods
        insertplayer:(user)->
            Users.insert user, (err,res)->
                if err?
                    console.log "#{ err }"
                else 
                    console.log res
                    
                   