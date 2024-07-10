local meta = require "meta"
local pkg = meta.loader(..., true)
local inspect=meta.no.require('inspect')
local usecolor=true
local default_level='info'
local save = meta.no.save

local function default_logger()
  for k,v in pairs(pkg) do
    if v then return v end
  end
end

local level = {
  ["trace"] ={ name = "trace", color = "\27[34m", level=10, },
  ["debug"] ={ name = "debug", color = "\27[36m", level=20, },
  ["info"]  ={ name = "info",  color = "\27[32m", level=30, },
  ["warn"]  ={ name = "warn",  color = "\27[33m", level=40, },
  ["err"]   ={ name = "error", color = "\27[31m", level=50, },
  ["fatal"] ={ name = "fatal", color = "\27[35m", level=60, },
}

local round = function(x, increment)
  increment = increment or 1
  x = x / increment
  return (x > 0 and math.floor(x + .5) or math.ceil(x - .5)) * increment
end

local _tostring = tostring
local tostring = function(...)
  local t = {}
  for i = 1, select('#', ...) do
    local x = select(i, ...)
    if type(x)=="number" then
      x = round(x, .01)
    end
    if type(x)=="table" then
      x = inspect and inspect(x) or x
    end
    t[#t + 1] = type(x)=="string" and x or _tostring(x)
  end
  return table.concat(t, " ")
end

return setmetatable({}, {
  __index=function(self, k)
    k=string.lower(k)
    if k=='default_level' then return save(self, k, default_level) end
    if k=='default' then return rawget(self, k) or save(self, k, (default_logger() or {}).default) end
    if not level[k] then return pkg[k] end
    return rawget(self, k) or save(self, k, function(...)
      local x = level[k]
      if x.level < level[self.default_level].level then
        return
      end

      if not x then error('logger: unknown loglevel ' .. tostring(k)) end
      local msg = tostring(...)
      local info = debug.getinfo(2, "Sl")
      local lineinfo = info.short_src .. ":" .. info.currentline

--      msg = string.format("%s[%-6s%s]%s %s: %s",
      msg = string.format("%s[%s]%s %s: %s",
                        usecolor and x.color or "",
                        k,
--                        "",
--                        os.date("%H:%M:%S"),
                        usecolor and "\27[0m" or "",
                        lineinfo,
                        msg)
      return (type(self.default)=='table' and type(self.default[k])=='function') and self.default[k](msg) or print(msg)
    end)
  end,
  __call=function(self, ...)
    return self.log(...)
  end,
})
