local mt      = require 'meta.gmt'
local number  = require 'meta.number'
local boolean = require 'meta.boolean'
require 'meta.string'
require 'meta.table'

return function(a, b)
  if type(a)~='table' and type(b)~='table' then return a==b end
  if type(a)=='table' and type(b)=='table' then
    local __eq=(getmetatable(a) or {}).__eq
    if __eq then return __eq(a, b) end
    __eq=(getmetatable(b) or {}).__eq
    if __eq then return __eq(b, a) end
    return table.equal(a, b)
  end
  if type(b)=='table' then a,b=b,a end
  if type(a)=='table' and getmetatable(a) then
    if type(b)=='number' and mt(a).__tonumber then return number(a)==b end
    if type(b)=='string' then return tostring(a)==b end
    if type(b)=='boolean' then return boolean(a)==b end
  end
  return false
end