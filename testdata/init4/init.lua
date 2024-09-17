local t = t or require "t"
return t.object({__tostring=function(self) return self.data end,}):loader(...):factory({data='okok'})
