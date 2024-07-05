local t = require "t"
return t.object({__tostring=function(self) return self.data end,}):loader(...):factory({data='okok'})
