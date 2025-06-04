local t = require 't'
local rex = t.rex
return t.is..{'rex', [false]=function(self, k, load) if type(self)=='table' and type(k)=='string' then
  return (rex and rex[k] or {}).matching or nil end return nil end,}