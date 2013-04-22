/*
    Brainfuck interpreter by github.com/1337
    How to run: (new $.brainfuck('>>>.')).run().out().reset();

    MIT Licence
*/
var $ = $ || {};

(function ($, moduleName) {
    "use strict";
    var pointer = 0;
    var pA = [];
    var buffer = "";

    var me = function(c) {
        this.c = c;

        this.run = function () {
            var index = -1;
            while (index < c.length) {
                index++;
                if (isNaN (pA[pointer])) {
                    pA[pointer] = 0;
                }
                switch (c[index]) {
                    case '>':
                        pointer++;
                        break;
                    case '<':
                        pointer--;
                        break;
                    case '+':
                        pA[pointer]++;
                        break;
                    case '-':
                        if (pA[pointer] > 0) {
                            pA[pointer]--;
                        }
                        break;
                    case '.':
                        buffer += String.fromCharCode(pA[pointer]);
                        break;
                    case ',':
                        pA[pointer] = prompt();
                        break;
                    case '[':
                        index += new me(this.c.substring(index+1)).run();
                        break;
                    case ']':
                        if (pA[pointer] == 0) {
                            return index + 1;
                        }
                        index = -1;
                    default:
                }
            }
            return this;
        };

        this.out = function () {
            alert(buffer);
            buffer = "";
        };

        this.reset = function () {
            pointer = 0;
            pA = [];
            buffer = "";
        };
    };

    if ($.pubSub) {
        $.pubSub(moduleName, [], me);  // register module
    }
    $[moduleName] = me;  // put it back (optional if you pubSub)
}($, /* [desired namespace] */ 'brainfuck'));