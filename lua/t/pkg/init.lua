local meta=require "meta"
return setmetatable({},{
__call=function(self, x, ...) if x then
  local mod=meta.module:pkg(x, ...) or {}
  return mod.loader
end end,
__index=meta.mt.pkg,
})