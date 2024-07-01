local meta    = require "meta"
local assert  = require "luassert"
local is      = require "t.is"
local no      = meta.no

for k,v in pairs(meta.loader(..., true)) do
	no.asserts(k, table.unpack(v), is[k])
end

return assert
