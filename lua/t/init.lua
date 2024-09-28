require "compat53"
require "luassert"
local meta = require "meta"
local no=meta.no

if not t then
  t = meta.loader('t') ^ 't'
  t:assert(no.asserted)
  t:init()
  t:patch(no.call)
end

return t
