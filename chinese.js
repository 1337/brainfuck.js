/*
    Chinese interpreter by github.com/1337
    Requires Brainfuck interpreter by github.com/1337
    How to run: (new $.chinese('我的大小不好')).run().out().reset();

    MIT Licence
 */
var $ = $ || {};

(function ($, moduleName) {
    "use strict";

    var bfAdapter = function (inca) {
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
        } catch (err) {
            return '';
        }
    };

    var me = function (code) {
        var bfCode = code.split('').map(bfAdapter).join('');
        return new $.brainfuck(bfCode);
    };

    if ($.pubSub) {
        $.pubSub(moduleName, [], me);  // register module
    }
    $[moduleName] = me;  // put it back (optional if you pubSub)
}($, /* [desired namespace] */ 'chinese'));