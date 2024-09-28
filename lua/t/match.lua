local pkg=(...) or 't/match'
local meta=require "meta"
return meta.wrapper('t/matcher', pkg) ^ string.matcher