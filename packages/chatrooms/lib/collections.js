(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.Mainchatmessages = new Meteor.Collection('chatmessages', {
    transform: function(doc) {
      var message;
      message = _.extend(new Chatmessage(), doc);
      return message;
    }
  });

  this.Players = new Meteor.Collection('players', {
    transform: function(doc) {
      var player;
      player = _.extend(new Player(), doc);
      return player;
    }
  });

  this.Rooms = new Meteor.Collection('rooms', {
    transform: function(doc) {}
  });

  this.RoomPlayers = new Meteor.Collection('roomplayers');

  this.Player = (function() {
    function Player(xconnection) {
      this.userId = Random.id();
      this.name = "anon";
      this.ingame = false;
      this.currentroom = "main";
      if (xconnection != null) {
        this.connection = {
          id: xconnection.id,
          ip: xconnection.clientAddress,
          httpheaders: xconnection.httpHeaders['user-agent']
        };
      }
    }

    return Player;

  })();

  this.Room = (function() {
    function Room(userId) {
      this.addplayer = __bind(this.addplayer, this);
      this.roomId = Random.Id();
      this.owner = userId;
      this.playersinroom = [];
    }

    Room.prototype.addplayer = function(player) {};

    Room.prototype.playercount = function() {};

    return Room;

  })();

  this.Chatmessage = (function() {
    function Chatmessage() {
      this.send = __bind(this.send, this);
      this.owner = "anon";
      this.chatmessageid = Meteor.uuid();
      this.timestamp = Date.now();
      this.roomid = null;
      this.content = "";
    }

    Chatmessage.prototype.send = function(error, result) {
      if (error != null) {
        console.log(error);
      } else {

      }
      this.content = "instance function test worked";
      return console.log(this.content);
    };

    return Chatmessage;

  })();

}).call(this);
