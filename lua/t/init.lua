local t = require('meta').loader('t') ^ true

if type(package.loaded.t)~='table' then
  if type(package.loaded.luassert)=='table' then
    _=t+'assert'
  end
end

if ngx and ngx.get_phase then
  if ngx.get_phase()=='init' then _=t+'init' end
end

return t