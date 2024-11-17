local t=t or require "t"
local to=t.to
return function(x) return math.round(to.number(x)) end