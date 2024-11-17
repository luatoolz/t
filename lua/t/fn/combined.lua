local meta = require "meta"
local is, pak, unpak =
  meta.is,
  pack or table.pack,
  unpack or table.unpack

return function(...)
  local func={...}
  return function(...)
    local rv=pak(...)
    for i,f in ipairs(func) do
      if is.callable(f) then
        rv=pak(f(unpak(rv)))
      end
    end
    return unpak(rv)
  end
end