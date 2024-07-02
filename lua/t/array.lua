local t = require "t"
local meta = require "meta"
local mt = meta.mt
local is = t.is

local args, iter = table.args, table.iter

return setmetatable({
  of=table.of,
},{
  __name='array',
  __item=t.fn.noop,
  __mod=table.filter,
  __mul=table.map,
  __iter=table.ivalues,
  __pairs=ipairs,
  __tostring=function(self)
    return table.concat(self, "\n")
  end,
  __call=function(self, ...)
    assert(is.mtequal(t.array, self, {'__item'}))
    assert(is.callable(mt(self).__item))
    return setmetatable({}, getmetatable(self)) .. args(...)
  end,
  __concat=function(self, o)
    assert(is.mtequal(t.array, self, {'__item'}))
    if is.bulk(o) then for it in iter(o) do _=self+it end end
    return self
  end,
  __add=function(self, it)
    assert(is.mtequal(t.array, self, {'__item'}))
    if is.bulk(it) then return self .. it end
    it=mt(self).__item(it)
    if it then table.insert(self, it) end
    return self
  end,
  __sub=function(self, it)
    assert(is.mtequal(t.array, self, {'__item'}))
    if is.bulk(it) then for o in iter(it) do _=self-o end end
    if it and type(it)=='number' then
      if it<1 or it>#self then it=nil end
      table.remove(self, it) end
    return self
  end,
  __unm=function(self)
    return #self>0 and table.remove(self) or nil
  end,
  __eq=function(a, b)
    assert(is.mtequal(t.array, a, {'__item'}))
    assert(type(a)=='table' and type(b)=='table')
    if #a~=#b then return false end
    if #a==0 then return (type(next(a))=='nil' and type(next(b))=='nil') and true or false end
    for i=1,#a do if a[i]~=b[i] then return false end end
    if type(table.keys(a)())~='nil' or type(table.keys(b)())~='nil' then return false end
    return true
  end,
})
