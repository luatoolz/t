local t=require "t"
local failed=t.failed
return function(...) return failed(...) end