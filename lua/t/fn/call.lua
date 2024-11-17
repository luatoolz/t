local callable = require"meta.is.callable"
return function(f, ...) if callable(f) then return f(...) else return ... end end