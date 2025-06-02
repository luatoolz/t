local number  = require 'meta.number'
local date    = require 't.date'
return function(x) return number(date(x)) end