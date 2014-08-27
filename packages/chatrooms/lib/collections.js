﻿(function() {
  var prof, ser,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.Boards = new Meteor.Collection('boards');

  this.Players = new Meteor.Collection('players');

  prof = {
    name: "bob",
    avatar: "",
    totaltokens: 3,
    gamestats: {
      won: 2,
      lost: 1
    },
    currentroom: "main"
  };

  ser = {
    username: "acdefgh",
    password: "hello",
    profile: prof
  };

  this.Profile = (function() {
    function Profile(params) {
      var type, _ref, _ref1;
      if (params == null) {
        params = {};
      }
      type = "Profile";
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

  this.Player = (function() {
    function Player(params) {
      var _ref, _ref1;
      if (params == null) {
        params = {};
      }
      this.getGamestats = __bind(this.getGamestats, this);
      this.addTokens = __bind(this.addTokens, this);
      this.changeName = __bind(this.changeName, this);
      console.log("usercon: " + params);
      this.password = (_ref = params.password) != null ? _ref : "1234";
      this.username = (_ref1 = params.username) != null ? _ref1 : "12345";
      this.profile = params;
    }

    Player.prototype.changeName = function(newName) {
      this.profile.name = newName;
      return console.log("Hello" + this.profile.name);
    };

    Player.prototype.addTokens = function(number) {
      this.profile.totaltokens += number;
      return console.log("you now have " + this.profile.totaltokens);
    };

    Player.prototype.getGamestats = function(which) {
      switch (which) {
        case "both":
          return console.log("wins: " + this.profile.gamestats.won + ", losses " + this.profile.gamestats.lost);
        case "won":
          return console.log("won" + this.profile.gamestats.won);
        case "lost":
          return console.log("lost" + this.profile.gamestats.lost);
      }
    };

    return Player;

  })();

  this.myprof = new Profile(prof);

  console.log(myprof);

  this.myuser = new User(myprof);

}).call(this);
