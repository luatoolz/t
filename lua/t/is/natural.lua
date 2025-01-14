local t=t or require "t"
local to=t.number.natural
return function(x) return to(x) and true end