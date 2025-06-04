local t = require 't'
local is, failed = t.is, t.failed
return function(x) return is(failed, x)  end