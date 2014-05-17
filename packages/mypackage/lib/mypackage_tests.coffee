class mySuite
  name: "mytests"

  testExample: (test) ->
    test.isTrue(true)

Munit.run( new mySuite())
