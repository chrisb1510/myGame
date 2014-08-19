if Meteor.isClient
	
	Template.pixi.piximain = ()->
		stage = new PIXI.Stage(0x66FF99)
		renderer = new PIXI.WebGLRenderer(400, 300)

		$("#pixiestage").append(renderer.view)

	Template.pixi.animate = -> 
    	requestAnimFrame( animate )
    	sprite.rotation += 0.1    
    	renderer.render(stage)

