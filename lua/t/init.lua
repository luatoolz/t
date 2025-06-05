local t = require('meta').loader('t') ^ true

if type(package.loaded.t)~='table' then
  if type(package.loaded.luassert)=='table' then
    _=t+'assert'
  end
end

return t