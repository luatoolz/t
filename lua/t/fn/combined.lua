local t = require "t"
local is = t.is
return function(...)
  local func={...}
  return function(...)
    local rv=table.pack(...)
    for i,f in ipairs(func) do
      assert(is.callable(f))
      rv=table.pack(f(table.unpack(rv)))
    end
    return table.unpack(rv)
  end
end
