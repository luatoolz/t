local t=t or require "t"
return function(x) return (type(x)=='number' and x<0) and x or nil end