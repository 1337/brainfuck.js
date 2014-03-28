// Generated by CoffeeScript 1.7.1
(function() {
  var Chinese,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Chinese = (function(_super) {
    __extends(Chinese, _super);

    function Chinese(code) {
      this.code = code.split(/[\n\s]/).map(this.to_bf).join("");
    }

    Chinese.prototype.to_bf = function(inca) {
      var err;
      try {
        return {
          '大': '>',
          '小': '<',
          '和': '+',
          '不': '-',
          '的': '.',
          '好': ',',
          '前': '[',
          '我': ']'
        }[inca.toLowerCase()];
      } catch (_error) {
        err = _error;
        return "";
      }
    };

    return Chinese;

  })(BrainFuck);

  window.Chinese = Chinese;

}).call(this);

//# sourceMappingURL=chinese.map
