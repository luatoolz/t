local t=t or require "t"
local null=t.fn.null
return setmetatable({},{
__call=function(self, ...) return self end,
__export=null,
__tostring=function(self) return '' end,
})