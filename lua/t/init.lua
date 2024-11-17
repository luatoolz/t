local meta = require "meta"

if not t then
  t = meta.loader('t') ^ 't'
  if package.loaded.luassert then
    t:assert(meta * 'assert')
  end
  t:init()
end

return t