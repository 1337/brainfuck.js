#
#    Brainfuck interpreter by github.com/1337
#    How to run: new $.brainfuck('>>>.')).run().out().reset();
#
#    MIT Licence
#
pointer = 0  # current memory address
stack = []  # array of values (memory)
buffer = ""

reset = ->
    pointer = 0
    stack = []
    buffer = ""

# taken from this jackass
# http://stackoverflow.com/questions/8567114/how-to-make-an-ajax-call-without-jquery#comment26730310_8567149
jax = (url, callback) ->
    if window.XMLHttpRequest
        xmlhttp = new XMLHttpRequest()
    else
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP")

    xmlhttp.onreadystatechange = ->
        if xmlhttp.readyState == 4 and xmlhttp.status == 200
            callback(xmlhttp.responseText or xmlhttp.response)

    xmlhttp.open "GET", url, true
    xmlhttp.send()


class BrainFuck
    constructor: (@code) ->

    run: (code=@code) ->
        pointer = 0
        index = -1
        while index++ < code.length

            # prevent miscalculations
            if isNaN stack[pointer]
                stack[pointer] = 0

            switch code[index]
                when ">"
                    pointer++
                when "<"
                    pointer--
                when "+"
                    stack[pointer]++
                when "-"
                    if stack[pointer] > 0
                        stack[pointer]--
                when "."
                    buffer += String.fromCharCode(stack[pointer])
                when ","
                    stack[pointer] = prompt()
                when "["
                    # while condition intercepted by code termination in ']'
                    index += (new BrainFuck(@code.substring(index + 1))).run()
                when "]"
                    if stack[pointer] is 0
                        return index + 1
                    index = -1
                else
        @

    out: (execute=true, reset=true) ->
        # completes the interpretation and outputs the result
        if execute
            try
                eval buffer
            catch err
                alert buffer
        if reset
            @reset()

        @toString()

    toString: ->
        buffer

    reset: ->
        reset()
        @


BrainFuck.from_js = (js='alert(undefined);') ->
    # translate js to bf.
    moveChar = (a, b) ->
        # returns the bit shifts required to move current value from a to b.
        # a and b are things with .charCodeAt()s.
        ordA = a.charCodeAt(0)
        ordB = b.charCodeAt(0)
        diff = ordB - ordA
        if diff == 0
            "."
        else if diff > 0
            Array(diff + 1).join("+") + "."
        else if diff < 0
            Array(-diff + 1).join("-") + "."

    js = "eval('" + js.replace(/'/g, "\\'") + "');"
    brainfuck_buffer = ""
    charAt = String.fromCharCode(0)

    while js.length > 0
        brainfuck_buffer += moveChar(charAt, js[0])
        charAt = js[0]
        js = js.substring(1)

    return brainfuck_buffer


BrainFuck.to_js = (bf) ->
    # run bf as js.
    runtime = new BrainFuck(bf)
    src = runtime.run().out(false, false)
    eval(src)
    runtime.reset()


# strap on some automatic text/brainfuck magic
previous_onload = window.onload
window.onload = ->
    if previous_onload
        previous_onload.apply(this, arguments)

    script_tags = document.getElementsByTagName('script')
    for tag in script_tags
        if tag.type.toLowerCase() is 'text/brainfuck'
            if tag.innerHTML  # is inline script
                setTimeout(->
                    BrainFuck.to_js(tag.innerHTML)
                , 0)
            else if tag.src  # is external
                jax tag.src, (bf) ->
                    BrainFuck.to_js(bf)

# lazy
window.BrainFuck = BrainFuck
