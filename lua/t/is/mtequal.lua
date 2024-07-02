require "meta"
return function(a, b, ignore)
  if type(a)~='table' or type(b)~='table' then return false end
  a = getmetatable(a)
  b = getmetatable(b)
  if type(a)~='table' or type(b)~='table' then return false end
  if type(ignore)~='table' then ignore={} end
  if #ignore>0 then ignore=table.tohash(ignore, true) end
  for i in pairs(a) do if not ignore[i] then if not rawequal(a[i], b[i]) then return false end end end
  return true
end
