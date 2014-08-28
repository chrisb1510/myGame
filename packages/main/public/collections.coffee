class @Player 
    
    constructor:(options)->
        @typeName="Player"
        @name = options?.name?.valueOf() or "anon" 
    
    clone:()->
        return new Player(@) 
    getTypeName:()-> return @typeName
    equals:(other)->
         if other.getTypeName() isnt @typeName 
             return false
         EJSON.stringify( @ ) == EJSON.stringify(other)
    toJSONValue:()->
         return {@typeName,@name}        
            
EJSON.addType "Player",(value) ->
    console.log value
    return new Player(value)          
        
class @tester 
    defaults =
        typeName:"tester"
        name:"anon"
    constructor:(options)->
       switch options?
           when true then  {@name,@typeName} = options
           when false then {@name,@typeName} = defaults
           
if Meteor.isClient
    Meteor.subscribe 'myusers' 
    @addplayer = ->
        myuser = new User(auser)
        Accounts.createUser myuser, (err)->
            if err?
                console.log "error : #{ err }"
            else
                console.log myuser
        Meteor.call "insertplayer", myuser, (err,res)->
            if res?
                console.log "result!: #{res}"
    

@Boards = new Meteor.Collection('boards')   
@Users = new Meteor.Collection 'myusers',
    transform:(doc)->
        new User(doc)
        

class @Profile
    constructor:(params={})->
        _.extend(@, params)
        @typeName = "Profile"
        console.log params
        @name = params.name ? "anon"
        @avatar = params.avatar ?  null
        @totaltokens = params.totaltokens ? 0
        @gameslost = params.gameslost ? 0
        @gameswon = params.gameswon ? 0
        @currentroom = params.currentroom ? "main"
    
    clone:()->
        return new Profile(@) 
    getTypeName:()-> return @typeName
    equals:(other)->
         if other.getTypeName() isnt @typeName 
             return false
         EJSON.stringify( @ ) == EJSON.stringify(other)
    toJSONValue:()->
         return { 
            typeName:@typeName
            name:@name
            avatar:@avatar
            totaltokens:@totaltokens
            gameslost:@gameslost
            gameswon:@gameswon
            currentroom:@currentroom}

EJSON.addType "Profile",(value) ->
    console.log value
    return new Profile(value)
         
class @User 
    constructor:(params)->
        @typeName = "User"
        console.log "usercon: "+ params.profile
        @username = params.username ? "12345"
        @password = params.password ? "1234"
        @profile =  new Profile(params.profile)  
        
    changeName: (newName) ->
        @profile.name = newName
        console.log "Hello"+ @profile.name
    addTokens:(number)->
        @profile.totaltokens += number
        console.log "you now have "+ @profile.totaltokens  
    getGamestats:(which)->
        switch which
          when "both" then console.log "wins: #{ @profile.gameswon }, losses #{ @profile.gameslost }"
          when "won" then  console.log "won" +@profile.gameswon
          when "lost" then console.log "lost"+@profile.gameslost 

    clone:()->
         new User(@) 
    getTypeName:()-> return @typeName
    equals:(other)->
         if other.getTypeName() isnt @typeName 
             return false
         EJSON.stringify( @ ) == EJSON.stringify(other)
    toJSONValue:()->
         return {
            typeName :@typeName
            username:@username
            password:@password
            profile:@profile}

EJSON.addType "User",(value) ->
    console.log value
    new User(value)

@mydoc =
  typeName:"tester"
  name:"test"
@mydoc2=
    typeName:"Player"
    name:"p1"

@prof=
    name:"bob"
    avatar:""
    totaltokens:3
    gameswon:2
    gameslost:1
    currentroom:"main"
   
@auser=
  username:"acdefgh"
  password:"hello"
  profile: prof

prof1 = new Profile(prof)

@user1 = new User(auser)


       
       
@test1 = new tester()
@test2 = new tester(mydoc) 
@player1 = new Player(mydoc2)