
Accounts.config {
	sendVerificationEmail:true
}
if Meteor.isClient
	Accounts.ui.config {
		passwordSignupFields:'USERNAME_AND_OPTIONAL_EMAIL'
	}

if Meteor.isServer
	Meteor.onConnection () -> console.log this.id+" "+ this.clientAddress
			






