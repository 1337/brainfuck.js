#
#    Chinese interpreter by github.com/1337
#    Requires Brainfuck interpreter by github.com/1337
#    How to run: (new Chinese('...')).run().out().reset();
#
#    MIT Licence
#
class Chinese extends BrainFuck
    constructor: (code) ->
        @code = code.split(/[\n\s]/).map(@to_bf).join("")
        super(@code)

    to_bf: (inca) ->
        try
            {
                '大': '>',
                '小': '<',
                '和': '+',
                '不': '-',
                '的': '.',
                '好': ',',
                '前': '[',
                '我': ']'
            }[inca.toLowerCase()]
        catch err
            ""

# lazy
window.Chinese = Chinese
