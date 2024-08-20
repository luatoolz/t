local t = t or require "t"
local meta = require "meta"
local mt = meta.mt

return {
__call=function(self, it)
  assert(type(it)=='table')
  local fields = mt(self).__imports or {}
  for k,v in pairs(fields) do
    local q=it[k]
    it[k]=v(q)
  end
  setmetatable(it, getmetatable(self))
  return toboolean(it) and it or nil
end,
__mod=function(self, it) -- build query
  return it and {[(mt(self).__id or {})[1]]=it} or nil
end,
__toboolean=function(self)
  for _,it in pairs(mt(self).__required or {}) do
    if not self[it] then return false end
  end
  return true
end,
}
