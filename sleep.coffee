#
#    Sleep interpreter by github.com/1337
#    Requires Brainfuck interpreter by github.com/1337
#    How to run: (new Sleep('zzz')).run().out().reset();
#
#    MIT Licence
#
class Sleep extends BrainFuck
    constructor: (code) ->
        @code = code.split(/[\n\s]/).map(@to_bf).join("")

    to_bf: (inca) ->
        try
            {
                z: ">"
                zz: "<"
                zzz: "+"
                zzzz: "-"
                zzzzz: "."
                zzzzzz: ","
                zzzzzzz: "["
                zzzzzzzz: "]"
            }[inca.toLowerCase()]
        catch err
            ""

# lazy
window.Sleep = Sleep
