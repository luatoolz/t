local t = require "t"
local noop = t.fn.noop

local index={}
local cached = {}
return setmetatable(cached, {
  __newindex=function(self, it, v) rawset(self, tonumber(it), v) end,
  __index=function(self, it) return rawget(self, tonumber(it)) end,
  __call=function(self, it)
    if self==cached then
      local rv = setmetatable({}, getmetatable(self))
      if type(it)=='function' then
        index[rv]=it
      else
        index[rv]=noop
      end
      return rv
    end
    assert(type(it)=='table')
    if not self[it] then self[it]=it end
    return it
  end,
})
