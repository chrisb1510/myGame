if Meteor.isClient
	Template.hello.greeting = ->
    	"Welcome to My Game."

  	Template.hello.events = "click input": ->
    	alert "You pressed the button"
  	Template.pixi.
  	Template.pixi.piximain = ()->
		@stage = new PIXI.Stage(0x66FF99)
		console.log stage
		@renderer = new PIXI.CanvasRenderer(400, 300)
		console.log renderer
		@x = renderer.view
		console.log x
		requestAnimationFrame(Template.pixi.animate)
		animate = ()-> 
    		requestAnimationFrame( Template.pixi.animate )
    		#sprite.rotation += 0.1    
    		#renderer.render(stage)
	pixiobject = @stage