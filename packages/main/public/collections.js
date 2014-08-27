(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  if (Meteor.isClient) {
    this.addplayer = function() {
      var myuser;
      myuser = new User(auser);
      Accounts.createUser(myuser, function(err) {
        if (err != null) {
          return console.log("error : " + err);
        }
      });
      console.log(myuser);
      return Meteor.call("insertplayer", myuser, function(err, res) {
        if (res != null) {
          return console.log("result!: " + res);
        }
      });
    };
    Meteor.subscribe('myusers');
  }

  this.Boards = new Meteor.Collection('boards');

  this.Users = new Meteor.Collection('myusers');

  this.prof = {
    name: "bob",
    avatar: "",
    totaltokens: 3,
    gamestats: {
      won: 2,
      lost: 1
    },
    currentroom: "main"
  };

  this.auser = {
    username: "acdefgh",
    password: "hello",
    profile: prof
  };

  this.Profile = (function() {
    function Profile(params) {
      var _ref, _ref1;
      if (params == null) {
        params = {};
      }
      this.type = "Profile";
      console.log(params);
      this.name = (_ref = params.name) != null ? _ref : "anon";
      this.avatar = (params.avatar != null) || null;
      this.totaltokens = (params.totaltokens != null) || 0;
      this.gamestats = {
        lost: params.gamestats.lost || 0,
        won: params.gamestats.won || 0
      };
      this.currentroom = (_ref1 = params.currentroom) != null ? _ref1 : "main";
    }

    return Profile;

  })();

  this.User = (function() {
    function User(params) {
      var _ref, _ref1;
      if (params == null) {
        params = {};
      }
      this.getGamestats = __bind(this.getGamestats, this);
      this.addTokens = __bind(this.addTokens, this);
      this.changeName = __bind(this.changeName, this);
      this.type = "User";
      console.log("usercon: " + params);
      this.username = (_ref = params.username) != null ? _ref : "12345";
      this.password = (_ref1 = params.password) != null ? _ref1 : "1234";
      this.profile = params.profile;
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
          return console.log("wins: " + this.profile.gamestats.won + ", losses " + this.profile.gamestats.lost);
        case "won":
          return console.log("won" + this.profile.gamestats.won);
        case "lost":
          return console.log("lost" + this.profile.gamestats.lost);
      }
    };

    return User;

  })();

}).call(this);
