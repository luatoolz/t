local t=t or require "t"
local pkg=t.pkg(...)
local num=pkg.number
return function(x) return math.round(num(x)) end