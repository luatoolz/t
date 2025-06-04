local t=require "t"
local is=t.is
local indexed=table.indexed
return setmetatable({}, {
  __add=function(self, it) if it and it~=true then table.insert(self, tostring(it)) end; return self end,
  __call=function(self, ok, ...) local e = ...
    if type(ok)~='nil' or e==true or type(e)=='nil' then return ok, ... end
    return setmetatable({...}, getmetatable(self)) end,
  __concat=function(self, it) if indexed(it) then
    for i=1,#it do local _ = self+it[i] end end; return self end,
  __name='failed',
  __mul=function(self, it) if is.callable(it) then it(table.unpack(self)) end; return self end,
  __pow=function(self, it) return self end,
  __toboolean=function(self) return false end,
  __tostring=function(self) return table.concat(self, ' ') end,
})