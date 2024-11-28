local t=t or require "t"
local int=t.to.integer
return function(x) return (type(x)=='number' and int(x)==x) and x or nil end