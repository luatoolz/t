local t=t or require "t"
local meta = require "meta"
local is, mt, export, iter, checker =
  t.is, meta.mt.mt, t.exporter, table.iter, meta.checker

local iterable=checker({['userdata']=true,['table']=true,['function']=true,},type)
local mts = {
  [getmetatable(table())]=true,
}

local array={}
setmetatable(array,{
  of=table.of,
  flatten=function(self, o) return array(table.flattened((is.array(self) and o) and o or self)) end,
  __add=function(self, it)
    if is.bulk(it) then return self .. it end
    local item=mt(self).__item
    if item and is.callable(item) then it=item(it) end
    if type(it)~='nil' then table.insert(self, it) end
    return self
  end,
  __array=true,
  __preserve=true,
  __call=function(self, ...)
    assert(is.similar(array, self))
    local item=mt(self).__item
    assert(type(item)=='nil' or is.callable(item))

    local len = select('#', ...)
    if len==0 then return setmetatable({}, getmetatable(self)) end
    local it = select(1, ...)
    if len==1 and iterable[it] then
      local gmt
      if type(it)=='userdata' and getmetatable(it) then
        gmt=getmetatable(it)
        if is.callable(gmt.__iter) then it=iter(it)
        elseif is.callable(gmt.__export) then it=export(it) end
      end
      if type(it)=='function' then return self() .. it end
      gmt=getmetatable(it)
      if type(it)=='table' and ((not gmt) or mts[gmt]) and (is.empty(it) or is.null(mt(self).__item)) then
        return setmetatable(it, getmetatable(self))
      end
    end
    return self() .. {...}
  end,
  __concat=function(self, it)
    if not is.similar(array, self) and type(self)=='table' and not getmetatable(self) then
      setmetatable(self, getmetatable(array)) end
    if is.bulk(it) then it=iter(it) end
    if is.func(it) then for x in it do local _=self+x end end
    return self
  end,
  __eq=function(a, b)
    if not is.similar(array, a) then a,b = b,a end
    assert(is.similar(array, a))
    assert(type(b)=='table')
    if #a~=#b then return false end
    if #a==0 then return (type(next(a))=='nil' and type(next(b))=='nil') and true or false end
    for i=1,#a do if a[i]~=b[i] then return false end end
    return true
  end,
  __index=function(self, k)
    if type(k)=='string' then return mt(self)[k] end
    return rawget(self, k)
  end,
  __iter=table.ivalues,
  __mod=table.filter,
  __mul=table.map,
  __name='array',
  __pairs=ipairs,
  __pow=function(self, x) return array:of(x) end,
  __sub=function(self, it)
    assert(is.similar(array, self))
    if is.bulk(it) then for x in iter(it) do local _=self-x end end
    if it and type(it)=='number' then
      if it<1 or it>#self then it=nil end
      table.remove(self, it) end
    return self
  end,
  __tonumber=function(self) return #self end,
  __tostring=function(self) assert(is.similar(array, self)); return table.concat(self*tostring, "\n") end,
  __unm=function(self) assert(is.similar(array, self)); return #self>0 and table.remove(self) or nil end,
})
mts[getmetatable(array)]=true
return array