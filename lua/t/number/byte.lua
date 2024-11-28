local t=t or require "t"
local pkg=t.pkg(...)
local int=pkg.integer
return function(x) return (type(x)=='number' and int(x)==x and x>=0 and x<=255) and x or nil end