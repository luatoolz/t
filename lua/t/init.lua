require "compat53"
require "luassert"
local meta = require "meta"

if not t then
  t = meta.loader(select(1, ...), false, true)
  require "t.is"
  require "t.assert"
  inspect = require "inspect"
end

return t
