(function() {
  this.Space = (function() {
    function Space(number, spacePos) {
      this.number = number;
      this.spacePos = spacePos;
      if (this.number === 1) {
        this.isStart = true;
      }
      this.tokens = 0;
      this.players = [];
      this.onEntry = function() {};
      this.onexit = function() {};
    }

    return Space;

  })();

  this.Board = (function() {
    function Board(numOfSpaces) {
      var i, spacePos, x, y, _i;
      this.Spaces = [];
      this.firstCorner = {
        x: 0,
        y: 0
      };
      for (i = _i = 0; 0 <= numOfSpaces ? _i < numOfSpaces : _i > numOfSpaces; i = 0 <= numOfSpaces ? ++_i : --_i) {
        if (i === 0) {
          x = this.firstCorner.x;
          y = this.firstCorner.y;
        } else {
          x += 50;
          y += 50;
        }
        spacePos = {
          x: x,
          y: y
        };
        this.Spaces[i] = new Space(++i, spacePos);
      }
      Meteor.call('newBoard', this, function(e, r) {
        if (r != null) {
          console.log(r);
          return this.boardId = r;
        } else {
          return console.log(e);
        }
      });
    }

    return Board;

  })();

}).call(this);
