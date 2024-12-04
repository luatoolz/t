local t=t or require "t"
local pkg, is, super = ..., t.is, {}
return setmetatable(super, {
__call=function(self, x)
  if type(x)~='table' then return pkg:error('no input table') end
  if rawequal(self, super) then
    return setmetatable(x, getmetatable(self))
  else
    local rv={}
    for k,v in pairs(self) do
      if is.callable(v) and type(x[k])~='nil' then
        rv[k]=v(x[k])
      end
    end
    return rv
  end
end,
})