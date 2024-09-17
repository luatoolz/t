local pkg=(...) or 't.strip'
local meta=require "meta"
return meta.wrapper('t.matcher', pkg) ^ string.stripper