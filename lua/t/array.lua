local t = require "t"
local meta = require "meta"
local mt = meta.mt
local is = t.is

local args, iter = table.args, table.iter

return setmetatable({
  of=table.of,
},{
  __item=t.fn.noop,
  __mod=table.filter,
  __mul=table.map,
  __pairs=table.values,
  __call=function(self, ...)
    assert(is.callable(mt(self).__item))
    return setmetatable({}, getmetatable(self)) .. args(...)
  end,
  __concat=function(self, o)
    assert(is.table.callable(self) and is.table.indexable(self))
    if is.bulk(o) then for it in iter(o) do _=self+it end end
    return self
  end,
  __add=function(self, it)
    assert(is.table.callable(self) and is.table.indexable(self))
    it=mt(self).__item(it)
    if it then table.insert(self, it) end
    return self
  end,
--  __sub=function(self, it)
--    assert(is.table.callable(self) and is.table.indexable(self))
--    it=mt(self).__item(it)
--    if it then self[it]=nil end
--    return self
--  end,
  __index=function(self, it)
    if type(it)=='nil' then return nil end
    assert(is.table.callable(self) and is.table.indexable(self))
    if type(it)=='number' then return rawget(self, it) end
    return mt(self)[it]
  end,
--  __newindex=function(self, it, v)
--    assert(is.table.callable(self) and is.table.indexable(self))
--    it=mt(self).__item(it)
--    if it and not self[it] then rawset(self, it, it) end
--  end,
--  __le=function(a, b)
--    assert(is.similar(a, b), 'require similar objects')
--    for it in iter(a) do if not b[it] then return false end end
--    return true
--  end,
--  __lt=function(a, b)
--    assert(is.similar(a, b), 'require similar objects')
--    return a <= b and not (b <= a)
--  end,
--  __eq=function(a, b)
--    assert(is.similar(a, b), 'require similar objects')
--    return a <= b and b <= a
--  end,
})
