local meta = require "meta"
local pkg=...
local callable = meta.is.callable
local xpcall = meta.fn.xpcall
return function(f, h)
  if not callable(f) then return pkg:error('argument function not callable') end
  h=h and callable(h) and h
  return function(...)
    return xpcall(f, h, ...)
  end
end