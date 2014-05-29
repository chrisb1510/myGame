should = chai.should()

class mainTests

	name : "mainProgramTests"

	tests: [{
		name:"watch user test"
		func:(test) ->
			test.isTrue(false,"this is the message")

	}]

Munit.run new mainTests 