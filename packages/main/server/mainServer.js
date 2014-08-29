(function() {
  if (Meteor.isServer) {
    Meteor.startup(function() {
      Users.remove({});
      Meteor.users.remove({});
      Meteor.publish('myusers', function() {
        return Users.find({});
      });
      Meteor.publish('myboards', function() {
        return Boards.find({});
      });
      Meteor.publish('myplayers', function() {
        return Players.find({});
      });
      return Meteor.publish('chatmessages', function() {
        return Messages.find({});
      });
    });
    Meteor.methods({
      insertuser: function(user) {
        return Users.insert(user, function(err, res) {
          if (err != null) {
            return console.log("" + err);
          } else {
            console.log(res);
            return res;
          }
        });
      },
      insertplayer: function(player) {
        return Players.insert(player, function(err, res) {
          if (err != null) {
            return console.log("" + err);
          } else {
            console.log(res);
            return res;
          }
        });
      },
      insertboard: function(board) {
        return Boards.insert(board, function(err, res) {
          if (err != null) {
            return console.log("" + err);
          } else {
            console.log(res);
            return res;
          }
        });
      },
      insertchatmessage: function(chatmessage) {
        return Messages.insert(chatmessage, function(err, res) {
          if (err != null) {
            return console.log("" + err);
          } else {
            console.log(res);
            return res;
          }
        });
      },
      clear: function(dbtoclear) {
        switch (dbtoclear) {
          case dbtoclear != null:
            return console.log("not found");
          case "boards":
            return Boards.remove({});
          case "players":
            return Players.remove({});
          case "users":
            return Users.remove({});
          case "chatmessages":
            return Messages.remove({});
          case "all":
            return (function() {
              Boards.remove({});
              Messages.remove({});
              Users.remove({});
              Messages.remove({});
              return true;
            })();
        }
      }
    });
  }

}).call(this);
