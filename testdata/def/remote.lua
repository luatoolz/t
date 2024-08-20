local t = require "t"

return setmetatable({
  type=t.string,
  id=t.string,
  host=t.string,
  userid=t.integer,
  [true]={
    id=[[id]],
    required=[[id host]],
  }
}, {
  ping=function(self) end,
  login=function(self, pass) end,
  __computed={
    session=function(self) end,
    company=function(self) end,
  },
})