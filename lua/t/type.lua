local t = require "t"
local meta = require "meta"
local cache = meta.cache
local typename = cache.typename

return function(o)
  return typename[o] or (type(o)=='table' and getmetatable(o) and typename[getmetatable(o)] or nil)
end
