local t=t or require "t"
local pkg=t.pkg(...)
local int=pkg.integer
return function(x) return (x and int(x)==x and x>=0) and x or nil end