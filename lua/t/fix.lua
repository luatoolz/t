local t=require "t"
local is, this = t.is, {}
local call = t.call

--[[
  object fields modifier
  designed for mapper calls

  define with named callable fields
    - each pair is called

  call format:
    - value, key, object, oid
--]]

return setmetatable(this, {
__call=function(self, x, key)
  if rawequal(self, this) then return (x and type(x)=='table') and setmetatable(x, getmetatable(self)) or nil end
  local rv={}
  for k,v in pairs(self) do
    if is.callable(v) then
      rv[k] = call(v, x[k], k, x, key)
    end
  end
  return rv
end,
})