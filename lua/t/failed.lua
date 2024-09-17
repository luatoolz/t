local t = t or require "t"
local report
return setmetatable({}, {
  __error='t/failed',
  __call=function(self, ok, e, ...)
    if type(ok)=='nil' and e then
      local rv={tostring(e)}
      for _,v in ipairs({...}) do
        v=v and tostring(v) or nil
        if v then table.insert(rv, v) end
      end
      setmetatable(rv, getmetatable(self))
      if report then print(rv) end
      return rv
    end
    return ok, e, ...
  end,
  __pow=function(self, it) report=it; return self end,
  __toboolean=function(self) return false end,
  __tostring=function(self) return table.concat(self, ' ') end,
})
