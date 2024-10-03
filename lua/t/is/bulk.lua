local meta=require "meta"
local t=t or require "t"
local is=t.is
local mt=meta.mt

return function(x) return (type(x)=='table' and (
  is.array(x) or is.set(x) or is.ofarray(x) or is.ofset(x) or is.table.iindexed(x) or
  x.__array or mt(x).__array or mt(x).__arraytype or mt(x).__jsontype=='array' or
  mt(x).__name=='json.array'
)) and true or false end