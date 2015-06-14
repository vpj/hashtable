#Hashtable

    DEFAULT_OPTIONS =
     reserved: 997
     valueArray: Float64Array
     keyArray: Int32Array
     multiple: 2
     resizeFactor: 1.9
     default: 0

    EMPTY = -2
    NO_NEXT = -1

    class Hashtable
     constructor: (options = {}) ->
      @_options = {}
      for k, v of DEFAULT_OPTIONS
       @_options[k] = options[k] ? v

      @_reset()

     resize: (reserved) ->
      if not reserved?
       reserved = Math.floor @_options.reserved * @_options.resizeFactor

      next = @_next
      values = @_values
      keys = @_keys
      M = @_M

      @_options.reserved = reserved
      @_reset()

      for i in [0...M] when next[i] isnt EMPTY
       @set keys[i], values[i]

     _reset: ->
      N = @_options.size = @_options.reserved * @_options.multiple
      @_next = new Int32Array N
      @_values = new @_options.valueArray N
      @_keys = new @_options.keyArray N
      @_N = 0
      for i in [0...N]
       @_next[i] = EMPTY
      @_M = @_options.reserved
      @_size = @_options.size
      @_reserved = @_options.reserved

     set: (key, value) ->
      if @_M + 1 >= @_size
       @resize()

      n = key % @_reserved
      while true
       if @_next[n] is EMPTY
        @_next[n] = NO_NEXT
        break
       break if @_keys[n] is key
       if @_next[n] is NO_NEXT
        @_next[n] = @_M++
        @_N++
       n = @_next[n]
      @_values[n] = value
      @_keys[n] = key

     get: (key, value) ->
      n = key % @_reserved
      while true
       return @_values[n] if @_keys[n] is key
       break if @_next[n] < 0
       n = @_next[n]

      return @_options.default

     toJSON: ->
      obj = {}
      for i in [0...@_M] when @_next[i] isnt EMPTY
       obj[@_keys[i]] = @_values[i]

      return obj



Set exports

    if module?
     module.exports = Hashtable
    else
     @Hashtable = Hashtable
