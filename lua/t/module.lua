local meta = require "meta"
local t=t or require "t"
local cache = meta.cache

-- now return meta.module() of base
-- use .loader computable to get loader
rawset(meta.module, 'base', function(it)
  if type(it)=='table' then it=cache.type[it] or cache.type[getmetatable(it)] end
  if not t.match.string(it) then return nil end
  return meta.module((meta.module(it) or {}).base)
end)

rawset(meta.module, 'basename', function(it)
  if type(it)=='table' then it=cache.type[it] or cache.type[getmetatable(it)] end
  if not t.match.string(it) then return nil end
  return (meta.module(it) or {}).base
end)

rawset(meta.module, 'childof', function(it)
  if type(it)=='table' then it=cache.type[it] or cache.type[getmetatable(it)] end
  if not t.match.string(it) then return nil end
  return meta.module((meta.module(it) or {}).parent)
end)

return meta.module
