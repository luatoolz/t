require 'compat53'
local t = require "t"
local is = t.is
return function(...)
  local func={...}
  return function(x)
    local rv=x
    for i,f in ipairs(func) do
      assert(is.callable(f))
      rv=f(rv)
    end
    return rv
  end
end
