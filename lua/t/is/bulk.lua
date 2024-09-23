local t=t or require "t"
local is=t.is
return function(x) return (type(x)=='table' and (is.array(x) or is.set(x) or is.ofarray(x) or is.ofset(x) or is.table.indexed(x))) and true or false end