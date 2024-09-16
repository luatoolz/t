local meta = require "meta"
local t=t or require "t"
return rawset(meta.module, 'base', function(path)
  if not t.match.string(path) then return nil end
  local base = (meta.module(path) or {}).base
  if base then return meta.loader(base) end
end)
