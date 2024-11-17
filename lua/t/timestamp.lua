local t = t or require "t"
local to, date = t.to, t.date
return function(x) return to.number(date(x)) end