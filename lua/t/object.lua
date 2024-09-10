require "compat53"
local meta = require "meta"
local no = require "meta.no"
local loader = require "meta.loader"
local mt = require "meta.mt"
local cache = require "meta.cache"
local is = require "t.is"
local clone = meta.clone

local tables = table{'__computed', '__computable', '__imports', '__required', '__id', '__default'}:tohash()

local function update(self, ...)
  assert(type(self)=='table')
  for i=1,select('#', ...) do
    local o = select(i, ...)
    if type(o)=='table' then
      for _,v in ipairs(o) do table.append(self, v) end
      for k,v in pairs(o) do self[k]=v end
    end
  end
  return self
end


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
  return setmetatable(table(t):uniq():null(), nil)
end

return mt({}, {
  mt          = function(self, t) if t then update(self.mm, t)   end; return self end,  -- static (mt) vars/func/methods
  imports     = function(self, t) if t then self.__imports=t    end; return self end,  -- imports spec (typed object vars)
  computed    = function(self, t) if t then self.__computed=t   end; return self end,  -- computed vars (saved)
  computable  = function(self, t) if t then self.__computable=t end; return self end,  -- computable vars (unsaved)
  default     = function(self, t) if t then self.__default=t    end; return self end,
  required    = function(self, t) if t then self.__required =uniq_split(t) end; return self end,
  ids         = function(self, t) if t then self.__id       =uniq_split(t) end; return self end,
  loader      = function(self, it, topreload, torecursive)
    if it then cache.loader[self.tt]=loader(it, topreload, torecursive) end; return self end,
  preindex    = function(self, f) if is.callable(f) then self.__preindex=f end;   return self end,  -- set __preindex function
  postindex   = function(self, f) if is.callable(f) then self.__postindex=f end;  return self end,  -- set __postindex function
  define      = function(self, t, name) if type(t)~='table' then return self end
    self:required(t[true]):ids(t._):computed(mt(t).__computed):computable(mt(t).__computable)
    t[false]=nil
    t[true]=nil
    t._=nil
    self:mt(table.filter(mt(t), is.callable))
    if name then self.__name=name end
    local rv={}
    for k,v in pairs(t) do
      if type(v)=='string' then
        local matcher=v=='' and string.matcher('.*') or string.matcher(v)
        rv[k]=function(x) return matcher(tostring(x)) end
      elseif type(v)=='boolean' then
        rv[k]=function(x) if type(x)=='nil' then x=v end; return toboolean(x) end
        self:default({[k]=v})
      elseif type(v)=='number' then
        if v==0 then rv[k]=tonumber
        elseif is.integer(v) then
          rv[k]=function(x) return (require "t").integer(x) or v end
          self:default({[k]=v})
        else
          rv[k]=tonumber
          self:default({[k]=v})
        end
      elseif is.callable(v) then rv[k]=v end
    end
    return self:imports(rv)
  end,
  definer = function(self) return function(x, name) return clone(self):define(x, name):factory() end end,
  factory     = function(this, t)
    local created = mt(this.tt:mtremove(t, false), this.mm:mtremove({
      __index=no.object,
      __newindex=function(self, key, value)
        local f = (mt(self).__imports or {})[key]
        if is.callable(f) then
          no.save(self, key, no.call(f, value)) else
          no.save(self, key, value)
        end
      end,
    }, false))
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
      self.mm[key]={}
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
        self.mm[key]=setmetatable(clone(v), nil)
      else
--        self.mm[key]=table(self.mm[key])
        update(self.mm[key], v)
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
