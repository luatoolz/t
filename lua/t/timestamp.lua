local t = t or require "t"
local date = t.date
return function(x) return tonumber(date(x)) end
