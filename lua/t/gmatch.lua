local pkg=(...) or 't.gmatch'
local meta=require "meta"
return meta.wrapper('t.matcher', pkg) ^ string.gmatcher