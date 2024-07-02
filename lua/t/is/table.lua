require "meta"
local t1, t2 = getmetatable(table()), getmetatable(table)
return function(x)
  if type(x)~='table' then return false end
  x=getmetatable(x)
  return ((type(x)=='nil') or (type(x)=='table' and (rawequal(x, t1) or rawequal(x, t2)))) and true or false end
--return (type(x)=='table' and (type(getmetatable(x))=='nil' or getmetatable(x)==t1 or getmetatable(x)==t2)) and true or false end
