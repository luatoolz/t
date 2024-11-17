local meta=require "meta"
return setmetatable({},{
__call=function(self, x) if type(x)=='number' then return x end end,
__index=meta.mt.pkg,
})