local t=t or require "t"
local is=t.is
local getmetatable = debug.getmetatable or getmetatable

local setup={
  [true]=function(self) self.__array=true; return self end,
  [false]=function(self) self.__array=nil; return self end,
}

local function exporter(x, fix, skip)
  if is.imaginary(x) then x=tostring(x) end
  if is.atom(x) then return x end
  local mt = getmetatable(x or {}) or {}
  local to = mt.__export
  if is.complex(x) and is.callable(to) and not skip then return to(x) end
  if type(x)=='table' then
    local array=false -- check for numeric indexes
    local rv={}
    for k,v in pairs(x) do
      if fix and type(k)=='number' then array=true end
      rv[k]=exporter(v, fix)
    end
    array=(fix and type(next(x))~='nil' and (array or mt.__array or mt.__arraytype)) and true or false
    return setup[array](rv)
  end
  error('unknown type' .. type(x))
end
return exporter
