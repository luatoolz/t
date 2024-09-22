require "compat53"
require "luassert"
local meta = require "meta"

if not t then
  t = meta.loader('t', false, true)
  _ = t['init.d'] .. true
end

return t ^ 't'
