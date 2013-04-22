/*
    Sleep interpreter by github.com/1337
    Requires Brainfuck interpreter by github.com/1337
    How to run: (new $.sleep('zzz')).run().out().reset();

    MIT Licence
 */
var $ = $ || {};

(function ($, moduleName) {
    "use strict";

    var bfAdapter = function (inca) {
        try {
            return {
                'z': '>',
                'zz': '<',
                'zzz': '+',
                'zzzz': '-',
                'zzzzz': '.',
                'zzzzzz': ',',
                'zzzzzzz': '[',
                'zzzzzzzz': ']'
            }[inca.toLowerCase()];
        } catch (err) {
            return '';
        }
    };

    var me = function (code) {
        var bfCode = code.split(/[\n\s]/).map(bfAdapter).join('');
        return new $.brainfuck(bfCode);
    };

    if ($.pubSub) {
        $.pubSub(moduleName, [], me);  // register module
    }
    $[moduleName] = me;  // put it back (optional if you pubSub)
}($, /* [desired namespace] */ 'sleep'));