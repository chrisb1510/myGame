
if Meteor.isClient
    
    @addplayer = ->
        myuser = new User(auser)
        Accounts.createUser myuser, (err)->
            if err?
                console.log "error : #{ err }"
        console.log myuser
        Meteor.call "insertplayer", myuser, (err,res)->
            if res?
                console.log "result!: #{res}"
    
    Meteor.subscribe 'myusers'               

    #@myprof = new Profile(prof)
    #console.log myprof
   

@Boards = new Meteor.Collection('boards')   
@Users = new Meteor.Collection('myusers')

         
@prof=
    name:"bob"
    avatar:""
    totaltokens:3
    gamestats: 
        won:2
        lost:1
    currentroom:"main"
   
@auser=
  username:"acdefgh"
  password:"hello"
  profile: prof

class @Profile
    constructor:(params={})->
        @type = "Profile"
        console.log params
        @name = params.name ? "anon"
        @avatar = params.avatar? or null
        @totaltokens = params.totaltokens? or 0
        @gamestats=
           lost :params.gamestats.lost or 0
           won :params.gamestats.won or 0
            
        @currentroom = params.currentroom ? "main"
    
     
class @User 
    constructor:(params={} )->
        @type = "User"
        console.log "usercon: "+ params
        @username = params.username ? "12345"
        @password = params.password ? "1234"
        
        @profile = params.profile  
        
    changeName: (newName) =>
        @profile.name = newName
        console.log "Hello"+ @profile.name
    addTokens:(number)=>
        @profile.totaltokens += number
        console.log "you now have "+ @profile.totaltokens  
    getGamestats:(which)=>
        switch which
          when "both" then console.log "wins: #{ @profile.gamestats.won }, losses #{ @profile.gamestats.lost }"
          when "won" then  console.log "won" +@profile.gamestats.won
          when "lost" then console.log "lost"+@profile.gamestats.lost 


