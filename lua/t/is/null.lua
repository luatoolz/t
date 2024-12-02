local t=t or require "t"
local null=t.null
return function(o) return type(o)=='nil' or rawequal(o,null) end
--return function(o) return type(o)=='nil' or (type(o)=='table' and rawequal(getmetatable(o),getmetatable(null))) end