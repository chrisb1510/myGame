(function() {
  var prof1;

  this.Player = (function() {
    function Player(options) {
      var _ref;
      this.typeName = "Player";
      this.name = (options != null ? (_ref = options.name) != null ? _ref.valueOf() : void 0 : void 0) || "anon";
    }

    Player.prototype.clone = function() {
      return new Player(this);
    };

    Player.prototype.getTypeName = function() {
      return this.typeName;
    };

    Player.prototype.equals = function(other) {
      if (other.getTypeName() !== this.typeName) {
        return false;
      }
      return EJSON.stringify(this) === EJSON.stringify(other);
    };

    Player.prototype.toJSONValue = function() {
      return {
        typeName: this.typeName,
        name: this.name
      };
    };

    return Player;

  })();

  EJSON.addType("Player", function(value) {
    console.log(value);
    return new Player(value);
  });

  this.tester = (function() {
    var defaults;

    defaults = {
      typeName: "tester",
      name: "anon"
    };

    function tester(options) {
      switch (options != null) {
        case true:
          this.name = options.name, this.typeName = options.typeName;
          break;
        case false:
          this.name = defaults.name, this.typeName = defaults.typeName;
      }
    }

    return tester;

  })();

  if (Meteor.isClient) {
    Meteor.subscribe('myusers');
    this.addplayer = function() {
      var myuser;
      myuser = new User(auser);
      Accounts.createUser(myuser, function(err) {
        if (err != null) {
          return console.log("error : " + err);
        } else {
          return console.log(myuser);
        }
      });
      return Meteor.call("insertplayer", myuser, function(err, res) {
        if (res != null) {
          return console.log("result!: " + res);
        }
      });
    };
  }

  this.Boards = new Meteor.Collection('boards');

  this.Users = new Meteor.Collection('myusers', {
    transform: function(doc) {
      return new User(doc);
    }
  });

  this.Profile = (function() {
    function Profile(params) {
      var _ref, _ref1, _ref2, _ref3, _ref4, _ref5;
      if (params == null) {
        params = {};
      }
      _.extend(this, params);
      this.typeName = "Profile";
      console.log(params);
      this.name = (_ref = params.name) != null ? _ref : "anon";
      this.avatar = (_ref1 = params.avatar) != null ? _ref1 : null;
      this.totaltokens = (_ref2 = params.totaltokens) != null ? _ref2 : 0;
      this.gameslost = (_ref3 = params.gameslost) != null ? _ref3 : 0;
      this.gameswon = (_ref4 = params.gameswon) != null ? _ref4 : 0;
      this.currentroom = (_ref5 = params.currentroom) != null ? _ref5 : "main";
    }

    Profile.prototype.clone = function() {
      return new Profile(this);
    };

    Profile.prototype.getTypeName = function() {
      return this.typeName;
    };

    Profile.prototype.equals = function(other) {
      if (other.getTypeName() !== this.typeName) {
        return false;
      }
      return EJSON.stringify(this) === EJSON.stringify(other);
    };

    Profile.prototype.toJSONValue = function() {
      return {
        typeName: this.typeName,
        name: this.name,
        avatar: this.avatar,
        totaltokens: this.totaltokens,
        gameslost: this.gameslost,
        gameswon: this.gameswon,
        currentroom: this.currentroom
      };
    };

    return Profile;

  })();

  EJSON.addType("Profile", function(value) {
    console.log(value);
    return new Profile(value);
  });

  this.User = (function() {
    function User(params) {
      var _ref, _ref1;
      this.typeName = "User";
      console.log("usercon: " + params.profile);
      this.username = (_ref = params.username) != null ? _ref : "12345";
      this.password = (_ref1 = params.password) != null ? _ref1 : "1234";
      this.profile = new Profile(params.profile);
    }

    User.prototype.changeName = function(newName) {
      this.profile.name = newName;
      return console.log("Hello" + this.profile.name);
    };

    User.prototype.addTokens = function(number) {
      this.profile.totaltokens += number;
      return console.log("you now have " + this.profile.totaltokens);
    };

    User.prototype.getGamestats = function(which) {
      switch (which) {
        case "both":
          return console.log("wins: " + this.profile.gameswon + ", losses " + this.profile.gameslost);
        case "won":
          return console.log("won" + this.profile.gameswon);
        case "lost":
          return console.log("lost" + this.profile.gameslost);
      }
    };

    User.prototype.clone = function() {
      return new User(this);
    };

    User.prototype.getTypeName = function() {
      return this.typeName;
    };

    User.prototype.equals = function(other) {
      if (other.getTypeName() !== this.typeName) {
        return false;
      }
      return EJSON.stringify(this) === EJSON.stringify(other);
    };

    User.prototype.toJSONValue = function() {
      return {
        typeName: this.typeName,
        username: this.username,
        password: this.password,
        profile: this.profile
      };
    };

    return User;

  })();

  EJSON.addType("User", function(value) {
    console.log(value);
    return new User(value);
  });

  this.mydoc = {
    typeName: "tester",
    name: "test"
  };

  this.mydoc2 = {
    typeName: "Player",
    name: "p1"
  };

  this.prof = {
    name: "bob",
    avatar: "",
    totaltokens: 3,
    gameswon: 2,
    gameslost: 1,
    currentroom: "main"
  };

  this.auser = {
    username: "acdefgh",
    password: "hello",
    profile: prof
  };

  prof1 = new Profile(prof);

  this.user1 = new User(auser);

  this.test1 = new tester();

  this.test2 = new tester(mydoc);

  this.player1 = new Player(mydoc2);

}).call(this);
