local t, is
return function(x)
  if type(x)~='table' then return false end
  t=t or require "t"
  is=is or t.is
  return is.mtequal(t.array, x, {'__item'})
end
