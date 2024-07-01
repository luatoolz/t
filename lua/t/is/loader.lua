local meta
return function(o)
  if not meta then
    meta = require "meta"
    assert(meta)
  end
	local mt = getmetatable(o)
	return type(mt)=='table' and (mt==getmetatable(meta) or mt==getmetatable(meta.loader)) end