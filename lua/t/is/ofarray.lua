local t=t or require "t"
local is=t.is
return function(x) return (type(x)=='table' and is.similar(t.array, x)) and true or nil end