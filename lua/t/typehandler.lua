local t = t or require "t"
local is = t.is

-- return type handler function
return function(o)
  return function(self, ...)
    local f = type(o)~='table' or o[type(self)]
    if is.callable(f) then return f(self, ...) end
  end
end
