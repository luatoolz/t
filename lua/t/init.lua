require "compat53"
require "luassert"
local meta = require "meta"
meta.no.track('t')

if not t then
  t = meta.loader(select(1, ...), false, true)
  require "t.is"
  require "t.assert"
  require "t.type"
  inspect = require "inspect"
end

return t
