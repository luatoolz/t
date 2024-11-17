local t=t or require "t"
return function(x, base)
  if type(x)=='number' then return x end
  if type(x)=='table' and (not getmetatable(x)) and #x>0 then return #x end
  if (type(x)=='table' or type(x)=='userdata') and getmetatable(x) then
    local mt=getmetatable(x)
    local tn=mt.__tonumber or mt.__len
    if type(tn)=='function' then return tn(x) end
  end
  if type(x)=='string' then return tonumber(x, base) end
end