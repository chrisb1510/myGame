class mySuite
  
  name: "mytests"
  should = chai.should()
  user = new User()
  user2 = new User("UserName")
  
  suiteSetup: ()->

  setup: ()-> 
  	
  testExample: (test) ->
    test.isTrue(true)

  test_MakeUser: (test) ->
   	user.should.be.ok

  test_TheUsersName:(test) ->
   	user2.name.should.be.equal "UserName"
  	
  test_TheUserPassword: (test)->
  	user.password.should.be.equal "password"

  test_PasswordMustBefiveChars: (test)->
  	user.password.length.should.be.greaterThan 5

  test_PasswordChange:(test)->
  	user.setPassword("fivechars")

  test_UserNameChange:(test)->
  	user2.setName("abcdefg")
  	user2.name.should.be.equal "abcdefg"

  test_userName25Chars:(test) ->
  	#check out of bounds
  	user2.setName "abcdefMghijklmnopqrstuvwxyzabcdef" 
  	#check a correct case
  	user2.setName "abcdedbe"
  	user2.name.should.be.equal "abcdedbe"
  
  #end of basic user setup


Munit.run( new mySuite() )
