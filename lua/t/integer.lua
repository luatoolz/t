local t = t or require "t"
return function(x) x=tonumber(x); return x and math.round(x) or x end
