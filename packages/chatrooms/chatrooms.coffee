Mainchatmessages = new Meteor.Collection 'mainchatmessages'
if Meteor.isServer
	Meteor.publish "mainchatmessages", ->
        Mainchatmessages.find({})
    Meteor.methods
    	updatechat: (chatmessage) ->
            Mainchatmessages.insert chatmessage
            

if Meteor.isClient
	Meteor.autorun ->
        Meteor.subscribe "mainchatmessages"
        return

	Template.chatmessages.mainchatmessages = ->
		Mainchatmessages.find( {}, {sort:{time:-1}})

	Template.entry.events = 
    'keydown input#chatText': (event) ->
        if event.which = 13
            if Meteor.user()
                user = Meteor.user()
                name = user.username
            else name = "anon"
            Mainchatmessage = $('#chatText').val() 
            if Mainchatmessage != ''
                chatmessage = 
                    name: name,
                    chatPosted: Mainchatmessage,
                    created: new Date()
                Meteor.call "updatechat",chatmessage
                $( '#chatText').value = ''
                Mainchatmessage = ''
                return