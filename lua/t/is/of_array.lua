local t, is
return function(...)
  t=t or require "t"
  is=is or t.is
  return is.of.array(...)
end
