#
#    Brainfuck interpreter by github.com/1337
#    How to run: new $.brainfuck('>>>.')).run().out().reset();
#
#    MIT Licence
#
class BrainFuck
    pointer: 0  # current memory address
    stack: []  # array of values (memory)
    buffer: ""
    constructor: (@code) ->

    run: (code=@code) ->
        @pointer = 0
        index = -1
        while index++ < code.length

            # prevent miscalculations
            if isNaN @stack[@pointer]
                @stack[@pointer] = 0

            switch code[index]
                when ">"
                    @pointer++
                when "<"
                    @pointer--
                when "+"
                    @stack[@pointer]++
                when "-"
                    if @stack[@pointer] > 0
                        @stack[@pointer]--
                when "."
                    @buffer += String.fromCharCode(@stack[@pointer])
                when ","
                    @stack[@pointer] = prompt()
                when "["
                    # while condition intercepted by code termination in ']'
                    index += (new BrainFuck(@code.substring(index + 1))).run()
                when "]"
                    if @stack[@pointer] is 0
                        return index + 1
                    index = -1
                else
        @

    out: (execute=true, reset=true) ->
        # completes the interpretation and outputs the result
        buffer = @buffer

        if execute
            try
                eval buffer
            catch err
                alert buffer
        if reset
            @reset()
        buffer

    reset: ->
        @pointer = 0
        @stack = []
        @buffer = ""
        @

# lazy
window.BrainFuck = BrainFuck
