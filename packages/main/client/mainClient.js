(function() {
  var mypixi, tiltListener;

  if (Meteor.isClient) {
    Template.hello.greeting = function() {
      return "Welcome to My Game.";
    };
    Template.hello.events = {
      "click input": function() {
        window.alert("You pressed the button");
      }
    };
    Template.pixi.rendered = function() {
      mypixi();
    };
    Template.gyro.rendered = function() {
      if (window.DeviceOrientationEvent != null) {
        window.addEventListener('deviceorientation', function(eventdata) {
          var compassdir, frontBackTilt, leftRightTilt;
          leftRightTilt = eventdata.gamma;
          frontBackTilt = eventdata.beta;
          compassdir = eventdata.alpha;
          tiltListener(leftRightTilt, frontBackTilt, compassdir);
        }, false);
      }
    };
  }

  tiltListener = function(LR, FB, compass) {
    var ball, cont, viewHeight, viewWidth;
    ball = $("#ball");
    cont = $("#gyrocontainer");
    viewWidth = cont.offsetWidth;
    viewHeight = cont.offsetHeight;
    if (FB > 90) {
      FB = 90;
    }
    if (FB < -90) {
      FB = -90;
    }
    LR += 90;
    FB += 90;
    $("#output").html("beta : " + FB + ": gamma: " + LR + ": compass" + compass);
    ball.style.top = (viewHeight * FB / 180) + "px";
    return ball.style.left = (viewWidth * LR / 180) + "px";
  };

  mypixi = function() {
    var animate, bunny, renderer, stage, texture;
    animate = function() {
      requestAnimFrame(animate);
      bunny.rotation += 0.1;
      renderer.render(stage);
    };
    stage = new PIXI.Stage(0x66FF99);
    renderer = PIXI.autoDetectRenderer(400, 300);
    $("#pixistage").append(renderer.view);
    requestAnimFrame(animate);
    texture = PIXI.Texture.fromImage("packages/main/public/img/bunny.png");
    bunny = new PIXI.Sprite(texture);
    bunny.anchor.x = 0.5;
    bunny.anchor.y = 0.5;
    bunny.position.x = 200;
    bunny.position.y = 150;
    stage.addChild(bunny);
  };

}).call(this);
