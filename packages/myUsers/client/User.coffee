class share.User
	#added share from meteor for package scope.
	#constructor assigns name
	constructor: (@name) ->
		@password = "password"

	setPassword: (newPassword) ->
		#this should check the length of a password
		if newPassword.length < 5
			@password = newPassword
			console.log "changed"
		else
			console.log "enter a longer pass"

	setName: (newName) ->
		if 1 < newName.length < 26
			@name = newName
			console.log @name
		else
			console.log "username must be 1 to 26 char"
			return false
		#this needs to check for existing users

