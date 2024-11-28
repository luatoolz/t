local t=t or require "t"
local to=t.number.integer
return function(x) return to(x) and true end