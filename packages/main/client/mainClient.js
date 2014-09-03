(function() {
  if (Meteor.isClient) {
    Meteor.subscribe('chatmessages');
    Meteor.subscribe('myusers');
    Meteor.subscribe('myboards');
    Meteor.subscribe('myplayers');
    Template.hello.helpers({
      greeting: function() {
        return "Welcome to My Game.";
      }
    });
    Template.hello.events = {
      "click input#tester": function() {
        return console.log("You pressed the cheese");
      }
    };
    Template.Userlist.helpers({
      defaultuser: function() {
        var user;
        return user = new User();
      },
      Usersinsameroom: function() {}
    });
    Template.Chatmessagelist.helpers({
      defaultmessage: function() {
        var message;
        return message = new Chatmessage().toJSONValue();
      },
      messageslistbyroom: function() {}
    });
    Template.GameBoard.helpers({
      defaultboard: function() {
        var board;
        return board = new Board().toJSONValue();
      }
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
      insertchatmessage: function(chatmessage) {
        return Messages.insert(chatmessage, function(err, res) {
          if (err != null) {
            return console.log("chat insert error : " + err);
          } else {
            console.log("Message inserted : " + res);
            return res;
          }
        });
      },
      insertboard: function(board) {
        return Boards.insert(board, function(err, res) {
          if (err != null) {
            return console.log("insert board error: " + err);
          } else {
            console.log("board added " + res);
            return res;
          }
        });
      },
      insertplayer: function(player) {
        return Players.insert(player, function(err, res) {
          if (err != null) {
            return console.log("insert player error " + err);
          } else {
            console.log("wecome player " + res);
            return res;
          }
        });
      },
      clear: function(dbtoclear) {
        switch (dbtoclear) {
          case "boards":
            return Boards.remove({});
          case "players":
            return Players.remove({});
          case "users":
            return Users.remove({});
          case "chatmessages":
            return Message.remove({});
          case void 0:
        }
      }
    });
  }

  this.defaultPlayer = new Player();

  this.defaultProfile = new Profile();

  this.defaultUser = new User();

  this.testProfile1 = new Profile({
    _id: Meteor.uuid(),
    name: "testProfile1",
    avatar: "monkey.png",
    totaltokens: 3,
    gameswon: 2,
    gameslost: 1,
    currentroom: "main"
  });

  this.testProfile2 = testProfile1.clone();

  testProfile2.name = "testProfile2";

  testProfile2.avatar = "tree.png";

  testProfile2._id = Meteor.uuid();

  console.log({
    testProfile1: testProfile1,
    testProfile2: testProfile2,
    defaultProfile: defaultProfile
  });

  this.testUser1 = new User({
    _id: Meteor.uuid(),
    username: "testUser1",
    password: "hello",
    profile: testProfile1
  });

  this.testUser2 = testUser1.clone();

  testUser2.username = "testUser2";

  testUser2._id = Meteor.uuid();

  console.log({
    testUser1: testUser1,
    testUser2: testUser2,
    defaultUser: defaultUser
  });

  this.defaultMessage = new Chatmessage();

  this.Message1 = new Chatmessage({
    owner: testUser1._id,
    message: "this test worked"
  });

  this.Message2 = new Chatmessage({
    owner: testUser2._id,
    message: "this test worked too"
  });

  console.log({
    Message1: Message1,
    Message2: Message2,
    defaultMessage: defaultMessage
  });

  this.test = function() {
    return Meteor.call("insertchatmessage", Message1, function(err, res) {
      if (err != null) {
        console.log("insert failed :" + err);
        return false;
      } else {
        console.log(res);
        return true;
      }
    });
  };

}).call(this);

//# sourceMappingURL=mainClient.js.map
