myAsyncFunction = (callback) ->
  callback "booyah"

should = chai.should()


class logintests
	
  name: "logintests"

  suiteSetup: ()->
    
    
  setup:() ->
  user = new User
  user2 = new User   
  console.log (user.class,user2.class) 

  test_a_User: (test) ->
    user.should.be.an.instanceof(User)
    
  
  test_a_Users_Name: (test) ->
    user.name = "chris"
    user.name.should.be.equal "chris"

  test_a_User_Password: (test) ->
    user2.password = "password"
    user2.password.should.be.equal "password"
  


  testAsync: (test, done) ->
    myAsyncFunction done((value) ->
      test.isNotNull value
    )

  testIsValid: (test) ->
    test.isTrue true

  clientTestIsClient: (test) ->
    test.isTrue Meteor.isClient
    test.isFalse Meteor.isServer

  serverTestIsServer: (test) ->
    test.isTrue Meteor.isServer
    test.isFalse Meteor.isClient

  tests: [
    {
      name: "sync test"
      func: (test)->

    },
    {
      name: "async test"
      skip: false
      func: (test, done)->
        myAsyncFunction done((value)->
          test.isNotNull(value)
        )

    },
    {
      name: "three"
      type: "client"
      timeout: 5000
      func: (test)->
        test.isTrue Meteor.isClient
    }
  ]

  tearDown: ->


  suiteTearDown: ->

Munit.run(new logintests())
