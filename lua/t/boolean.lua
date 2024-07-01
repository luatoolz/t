local t = require "t"
assert(type(toboolean)=='function')
return function(x) return toboolean(x) end
