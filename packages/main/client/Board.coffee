     
class @Space
    constructor:(@number,@spacePos)->
        #sets the space number
        if @number is 1
            @isStart = true
        @tokens = 0
        @players = []
        @onEntry = ()->
            return
        @onexit = () ->
            return
            
class @Board
    
    constructor:(numOfSpaces)->
        
        @Spaces = []
        @firstCorner=
            x   :   0
            y   :   0
            
        #make spaces from class and allocate x,y of each
        for i in [0...numOfSpaces]
            if i is 0
                x = @firstCorner.x
                y = @firstCorner.y
            else
                x += 50
                y += 50    
            spacePos = 
                    x   : x 
                    y   : y 
            
            @Spaces[i] = new Space(++i,spacePos)
        #insert this object into the db    
        Meteor.call 'newBoard', @, (e,r)->
            if r?
                console.log r
                #set the id of the board from server method.
                return @boardId = r
            else
                console.log e
        
