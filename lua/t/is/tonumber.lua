local meta=require"meta"
local mt=meta.mt
local types=('table userdata'):tohash()
return function(x) return (types[type(x)] and mt(x).__tonumber) and true or false end
