local t=t or require "t"
--local pkg=t.pkg(...)
local num, izpositive =
  tonumber,
--  pkg.number,
  t.number.izpositive
return function(x) return izpositive(num(x)) end