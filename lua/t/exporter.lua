local t=t or require "t"
local is=t.is
local getmetatable = debug.getmetatable or getmetatable
local inspect = require "inspect"

local function find_complex(x)
  if not is.complex(x) then return false end
  if is.imaginary(x) or type(x)=='userdata' or getmetatable(x) then return true end
  for k,v in pairs(x) do if find_complex(v) then return true end end
  return false
end

local setup={
  [true]=function(self) self.__array=true; return self end,
  [false]=function(self) self.__array=nil; return self end,
}

local function exporter(x, fix, skip)
  if is.imaginary(x) then x=tostring(x) end
  if is.atom(x) then return x end
  local mt = getmetatable(x or {}) or {}
  local to = mt.__export
  if is.complex(x) then
    if is.callable(to) and not skip then x=to(x)
      return (skip or (not find_complex(x))) and x or exporter(x, fix, skip)
    end
    local rv={}
    local array
    if type(x)=='table' and not getmetatable(x) then
      if x[1] or #x>0 or table.maxi(x)>0 then
        for i=1,table.maxi(x) do
          local v=x[i]
          table.insert(rv, is.complex(v) and exporter(v, fix) or v)
        end
        array=fix and true or false
        return setup[array](rv)
      end
      if type(next(x))~='nil' then
        for k,v in pairs(x) do
          rv[k]=exporter(v, fix)
        end
      end
      return setup[false](rv)
    end
    if mt.__pairs or mt.__iter then
      if mt.__pairs then
        for k,v in pairs(x) do
          if fix and type(k)=='number' then array=true end
          rv[k]=exporter(v, fix)
        end
      elseif mt.__iter then
        for v in table.iter(x) do
          table.insert(rv, is.complex(v) and exporter(v, fix) or v)
        end
        array=true
      end
      array=(fix and type(next(x))~='nil' and (array or mt.__array or mt.__arraytype)) and true or false
      return setup[array](rv)
    else
      if mt.__tostring then return tostring(x) end
    end
  end
  error(('unknown type: %s, mt: %s'):format(type(x), inspect(getmetatable(x))))
end
return exporter
