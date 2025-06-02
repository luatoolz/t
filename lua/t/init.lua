local meta    = require 'meta'
---local call    = meta.call
local loader  = meta.loader
local t       = loader('t') ^ true

if type(package.loaded.t)~='table' then
  if type(package.loaded.luassert)=='table' then
    t.assert()
  end
  t.init()
end

return t