var p = 0;
var pA = [];
var b = "";

function brainfuck (c) {
    this.c = c;
    
    this.run = function () {
        var i = -1;
        while (i < c.length) {
            i++;
            if (isNaN (pA[p])) {
                pA[p] = 0;
            }
            switch (c[i]) {
                case '>':
                    p++;
                    break;
                case '<':
                    p--;
                    break;
                case '+':
                    pA[p]++;
                    break;
                case '-':
                    if (pA[p] > 0) {
                        pA[p]--;
                    }
                    break;
                case '.':
                    b += String.fromCharCode (pA[p]);
                    break;
                case ',':
                    pA[p] = prompt ();
                    break;
                case '[':
                    i += new brainfuck (this.c.substring(i+1)).run();
                    break;
                case ']':
                    if (pA[p] == 0) {
                        return i + 1;
                    }
                    i = -1;
                default:
            }
        }
    }
    
    this.out = function () {
        alert (b);
        b = "";
    }
    
    this.reset = function () {
        p = 0;
        pA = [];
        b = "";
    }
}