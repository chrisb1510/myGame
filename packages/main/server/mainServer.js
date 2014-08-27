(function() {
  if (Meteor.isServer) {
    Meteor.startup(function() {
      Users.remove({});
      return Meteor.users.remove({});
    });
    Meteor.publish('myusers', function() {
      return Users.find({});
    });
    Meteor.methods({
      insertplayer: function(user) {
        return Users.insert(user, function(err, res) {
          if (err != null) {
            return console.log("" + err);
          } else {
            return console.log(res);
          }
        });
      }
    });
  }

}).call(this);
