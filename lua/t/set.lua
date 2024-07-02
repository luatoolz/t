local t = require "t"
local meta = require "meta"
local mt = meta.mt
local is = t.is

local args, iter = table.args, table.iter

return setmetatable({
  of=table.of,
},{
  __item=t.fn.noop,
  __iter=table.values,
  __mod=table.filter,
  __tostring=function(self)
    return table.concat(self, "\n")
  end,
  __call=function(self, ...)
    assert(is.callable(mt(self).__item))
    return setmetatable({}, getmetatable(self)) .. args(...)
  end,
  __index=function(self, it)
    if type(it)=='nil' then return nil end
    assert(is.table.callable(self) and is.table.indexable(self))
    return rawget(self, mt(self).__item(it))
  end,
  __newindex=function(self, it, v)
    assert(is.table.callable(self) and is.table.indexable(self) and it)
    it=mt(self).__item(it)
    if it and v and not self[it] then rawset(self, it, it) end
  end,
  __concat=function(self, o)
    assert(is.table.callable(self) and is.table.indexable(self))
    if is.bulk(o) then for it in iter(o) do
      _ = self + it end end
    return self
  end,
  __add=function(self, it)
    assert(is.table.callable(self) and is.table.indexable(self))
    if not it then return self end
    if is.bulk(it) then return self .. it end
    if it and not self[it] then self[it]=it end
    return self
  end,
  __sub=function(self, it)
    assert(is.table.callable(self) and is.table.indexable(self))
    if is.bulk(it) then for o in iter(it) do _=self-o end; return self end
    it=mt(self).__item(it)
    if it and self[it] then rawset(self, it, nil) end
    return self
  end,
  __mul=function(self, it)
    if type(it)=='function' then return table.map(self, it) end
    if type(it)=='table' then
      local rv = self(it)
      for x in pairs(rv) do if not self[x] then _=rv-x end end
      return rv
    end
  end,
  __le=function(a, b)
    assert(is.similar(a, b), 'require similar objects')
    for it in iter(a) do if not b[it] then return false end end
    return true
  end,
  __lt=function(a, b)
    assert(is.similar(a, b), 'require similar objects')
    return a <= b and not (b <= a)
  end,
  __eq=function(a, b)
    assert(is.similar(a, b), 'require similar objects')
    return a <= b and b <= a
  end,
})
