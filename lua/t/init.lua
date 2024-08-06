require "compat53"
require "luassert"
local pkg = ...
local meta = require "meta"

if not t then
  t = meta.loader(pkg, false, true)
  _ = t['init.d'] .. true
end

return t ^ pkg
