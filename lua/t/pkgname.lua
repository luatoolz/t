local t=t or require "t"
return function(x) return (t.pkg(x) or {}).name end