(function() {
  this.Boards = new Meteor.Collection('myboards', {
    transform: function(doc) {
      return new Board(doc);
    }
  });

  Boards.allow({
    insert: function(doc) {
      return true;
    },
    update: function(doc) {
      return true;
    },
    remove: function(doc) {
      return true;
    }
  });

  this.Users = new Meteor.Collection('myusers', {
    transform: function(doc) {
      return new User(doc);
    }
  });

  Users.allow({
    insert: function(doc) {
      return true;
    },
    update: function(doc) {
      return true;
    },
    remove: function(doc) {
      return true;
    }
  });

  this.Messages = new Meteor.Collection('chatmessages', {
    transform: function(doc) {
      return new Chatmessage(doc);
    }
  });

  Messages.allow({
    insert: function(doc) {
      return true;
    },
    update: function(doc) {
      return true;
    },
    remove: function(doc) {
      return true;
    }
  });

  this.Players = new Meteor.Collection('myplayers', {
    transform: function(doc) {
      return new Player(doc);
    }
  });

  Players.allow({
    insert: function() {
      return true;
    },
    update: function() {
      return true;
    },
    remove: function() {
      return true;
    }
  });

  this.Player = (function() {
    function Player(_arg) {
      var _ref;
      _ref = _arg != null ? _arg : {}, this.number = _ref.number, this.name = _ref.name;
      if (this.typeName == null) {
        this.typeName = "Player";
      }
      if (this.number == null) {
        this.number = "n/a";
      }
      if (this.name == null) {
        this.name = "anon";
      }
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
        _id: this._id,
        typeName: this.typeName,
        name: this.name,
        number: this.number
      };
    };

    EJSON.addType("Player", function(value) {
      console.log(value);
      return new Player(value);
    });

    return Player;

  })();

  this.Chatmessage = (function() {
    function Chatmessage(_arg) {
      var _ref;
      _ref = _arg != null ? _arg : {}, this.created = _ref.created, this.owner = _ref.owner, this.message = _ref.message, this.room = _ref.room;
      if (this.typeName == null) {
        this.typeName = "Chatmessage";
      }
      if (this.created == null) {
        this.created = new Date();
      }
      if (this.owner == null) {
        this.owner = "admin";
      }
      if (this.message == null) {
        this.message = "dEFAULT MESSAGE";
      }
      if (this.room == null) {
        this.room = "main";
      }
    }

    Chatmessage.prototype.clone = function() {
      return new Chatmessage(this);
    };

    Chatmessage.prototype.getTypeName = function() {
      return this.typeName;
    };

    Chatmessage.prototype.equals = function(other) {
      if (other.getTypeName() !== this.typeName) {
        return false;
      }
      return EJSON.stringify(this) === EJSON.stringify(other);
    };

    Chatmessage.prototype.toJSONValue = function() {
      return {
        _id: this._id,
        typeName: this.typeName,
        created: this.created,
        owner: this.owner,
        message: this.message
      };
    };

    EJSON.addType("Chatmessage", function(value) {
      console.log(value);
      return new Chatmessage(value);
    });

    return Chatmessage;

  })();

  this.Profile = (function() {
    function Profile(_arg) {
      var _ref;
      _ref = _arg != null ? _arg : {}, this.name = _ref.name, this.avatar = _ref.avatar, this.totaltokens = _ref.totaltokens, this.gameslost = _ref.gameslost, this.gameswon = _ref.gameswon, this.currentroom = _ref.currentroom;
      if (this.typeName == null) {
        this.typeName = "Profile";
      }
      if (this.name == null) {
        this.name = "anon";
      }
      this.avatar = "generic.png";
      if (this.totaltokens == null) {
        this.totaltokens = 0;
      }
      if (this.gameslost == null) {
        this.gameslost = 0;
      }
      if (this.gameswon == null) {
        this.gameswon = 0;
      }
      if (this.currentroom == null) {
        this.currentroom = "main";
      }
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

    EJSON.addType("Profile", function(value) {
      console.log(value);
      return new Profile(value);
    });

    return Profile;

  })();

  this.User = (function() {
    function User(_arg) {
      var _ref;
      _ref = _arg != null ? _arg : {}, this._id = _ref._id, this.username = _ref.username, this.password = _ref.password, this.profile = _ref.profile;
      this.typeName = "User";
      if (this._id == null) {
        this._id = null;
      }
      if (this.username == null) {
        this.username = 1;
      }
      if (this.password == null) {
        this.password = "default";
      }
      if (this.profile == null) {
        this.profile = new Profile();
      }
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

    EJSON.addType("User", function(value) {
      console.log(value);
      return new User(value);
    });

    return User;

  })();

}).call(this);
