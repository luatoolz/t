local t, is
return function(x)
  if type(x)~='table' then return false end
  t=t or require "t"
  is=is or t.is
  return (is.table(x) or is.mtequal(t.set, x, {'__item'}) or is.mtequal(t.array, x, {'__item'})) and true or false end
