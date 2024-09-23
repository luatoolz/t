require "compat53"
require "luassert"
local meta = require "meta"

if not t then
  t = meta.loader('t')
  t:assert(meta.no.asserted)
  t:init()
end

return t ^ 't'
