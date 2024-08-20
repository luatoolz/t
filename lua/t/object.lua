require "compat53"
local meta = require "meta"
local no = require "meta.no"
local loader = require "meta.loader"
local mt = require "meta.mt"
local cache = require "meta.cache"
local is = require "t.is"
local clone = meta.clone

local tables = table{'__computed', '__computable', '__imports', '__required', '__id'}:tohash()

--[[
---------------------------------------------------------
  usage (1): call methods

  return t.object({...})
        :imports({...})
        :preindex({...})
        :postindex({...})
        :computed(...)
        :loader({...})
        :factory({})

  usage (2): assign to mt vars
  local o = t.object()
  o.__imports = {...}
  o.__computed = {...}

  o.__computable.id=function(...) return ... end
  o.__computable.id = t.db.mongo.oid

  MANDATORY: --> call o:factory()
--------------------------------------------------------]]

local function uniq_split(t)
  if type(t)=='string' then t=t:split(' ') end
  if type(t)~='table' then t=nil end
  return table(t):uniq():null()
end

return mt({}, {
  mt          = function(self, t) self.mm:update(t);  return self end,  -- static (mt) vars/func/methods
  imports     = function(self, t) self.__imports=t;   return self end,  -- imports spec (typed object vars)
  computed    = function(self, t) self.__computed=t;  return self end,  -- computed vars (saved)
  computable  = function(self, t) self.__computable=t;return self end,  -- computable vars (unsaved)
  required    = function(self, t) self.__required =uniq_split(t); return self end,
  ids         = function(self, t) self.__id       =uniq_split(t); return self end,
  loader      = function(self, it, topreload, torecursive)
    if it then cache.loader[self.tt]=loader(it, topreload, torecursive) end; return self end,
  preindex    = function(self, f) if is.callable(f) then self.__preindex=f end;   return self end,  -- set __preindex function
  postindex   = function(self, f) if is.callable(f) then self.__postindex=f end;  return self end,  -- set __postindex function
  define      = function(self, t)
    t=t or {}
    local tr = t[true] or {}
    local tm=table(mt(t))
    t=table(t)
    return self
      :computed(tm.__computed)
      :computable(tm.__computable)
      :mt(tm % is.callable)
      :required(tr.required)
      :ids(tr.id)
      :imports(t % is.callable)
  end,
  definer = function(self) return function(x) return clone(self):define(x):factory() end end,
  factory     = function(this, t)
    local created = mt(this.tt:mtremove(t), this.mm:mtremove({
      __index=no.object,
      __newindex=function(self, key, value)
        local f = (mt(self).__imports or {})[key]
        if is.callable(f) then
          no.save(self, key, no.call(f, value)) else
          no.save(self, key, value)
        end
      end,
    }))
    if cache.loader[created] then
      cache.loader[getmetatable(created)]=cache.loader[created]
    end
    return created
  end,
  __index=function(self, key)
    assert(type(self)=='table')
    assert(type(key)~='nil')
    if type(next(self))=='nil' then return nil end
    if tables[key] then
      self.mm[key]=table()
      return self.mm[key]
    end
    return mt(self)[key] or self.mm[key]
    end,
  __newindex = function(self, key, v)
    assert(type(self)=='table')
    if type(key)=='nil' or type(v)=='nil' then return end
    if type(v)=='table' then
--      v=clone(v)
      if type(self.mm[key])~='table' then
        self.mm[key]=clone(v)
      else
        self.mm[key]=table(self.mm[key])
        self.mm[key]:update(v)
      end
    else
      self.mm[key]=v
    end
  end,
  __call = function(self, newmeta)
    assert(type(self) == 'table', 'await table, got ' .. type(self))
    assert(type(getmetatable(self)) == 'table', 'await mt(table), got ' .. type(getmetatable(self)))
    return setmetatable({tt=table({}), mm=table(newmeta or {})}, getmetatable(self))
  end,
})
