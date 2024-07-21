local t = require "t"
tointeger=tointeger or function(x) x=tonumber(x); return x and math.ceil(x) or x end
return tointeger