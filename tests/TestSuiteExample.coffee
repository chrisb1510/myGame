myAsyncFunction = (callback) ->
  callback "booyah"

class myGameMainTests
	
  name: "Mainproject"

  suiteSetup: ()->

  setup: ->

  test1Async: (test, done) ->
    myAsyncFunction done((value) ->
      test.isNotNull value
    )

  test1IsValid: (test) ->
    test.isTrue true

  clientTest1IsClient: (test) ->
    test.isTrue Meteor.isClient
    test.isFalse Meteor.isServer

  serverTest1IsServer: (test) ->
    test.isTrue Meteor.isServer
    test.isFalse Meteor.isClient

  tests: [
    {
      name: "sync test1"
      func: (test)->

    },
    {
      name: "async test1"
      skip: false
      func: (test, done)->
        myAsyncFunction done((value)->
          test.isNotNull(value)
        )

    },
    {
      name: "three1"
      type: "client"
      timeout: 5000
      func: (test)->
        test.isTrue Meteor.isClient
    }
  ]

  tearDown: ->

  suiteTearDown: ->

Munit.run(new myGameMainTests())
