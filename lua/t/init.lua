require "compat53"
require "luassert"
local pkg = ...
local meta = require "meta"

if not t then
  t = meta.loader(pkg or 't', false, true)
  assert(t)
  local i = t['init.d']
  assert(getmetatable(i) == getmetatable(t))
  _ = i .. true
--  local i = (t or {})['init.d']
--  if i then _ = i .. true end
end

return (t or 1) ^ pkg
