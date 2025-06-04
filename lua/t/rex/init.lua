local rexlib = require 'rex_pcre2'
local t = require 't'
local pkg = t.pkg(...)
local mt = t.mt
local call = t.call
local save = table.save
local computed = mt.computed

local tab = table()
local default = 'i' -- imsxU
local config  = rexlib.config()
local make    = rexlib.maketables()
mt(make).__metatable = nil
_ = config

local function nuller(...) return nil end
local function topack(...) return table.nulled(table(...)) or nil end
local function nonempty(s,l) return (s or type(l)~='nil') and s or nil end
local invert = {
  ltrim   = true,
  rtrim   = true,
  trim    = true,
  match   = true,
  matchs  = true,
  gsub    = true,
  gsuber  = true,
  find    = true,
  tfind   = true,
  gmatch  = true,
  count   = true,
  split   = true,
  splitz  = true,
}

return setmetatable({},{
__computed = {
  ok        = function(self) return (#self>0 and type(self.compiled)~='nil') and true or nil end,
  iscomplex = function(self) return self.isindexed or self.isnamed end,
  isindexed = function(self) local p=self.pattern;  return (type(p)=='string' and (p:match('[^%\\]%([^%?]') or p:match('^%([^%?]'))) and true or nil end,
  isnamed   = function(self) local p=self.pattern;  return (type(p)=='string' and p:match('%(%?%<[%w_]+%>')) and true or nil end,
  iswhole   = function(self) local p=self.pattern;  return (type(p)=='string' and p:match('^%^.+%$$')) and true or nil end,

  patterns  = function(self) local p=self.pattern;  return type(p)=='string' and p:gsub('^%^',''):gsub('%$$','') or nil end,
  startp    = function(self) local p=self.patterns; return type(p)=='string' and '^'..p or nil end,
  endp      = function(self) local p=self.patterns; return type(p)=='string' and p..'$' or nil end,

  compiled  = function(self) return rexlib.new(self.pattern,  self.options or default) end,
  compileds = function(self) return rexlib.new(self.patterns, self.options or default) end,

  ltrim     = function(self) return self.ok and function(s) return s and rexlib.gsub(s, self.startp, '') or nil end end,
  rtrim     = function(self) return self.ok and function(s) return s and rexlib.gsub(s, self.endp, '') or nil end end,
  trim      = function(self) return self.ok and function(s) return self.ltrim(self.rtrim(s)) end end,

  matching  = function(self) return self.ok and call.lift(self.match, function(x) return x and true or nil end) end,
--function(s, ...)    s=string(s, true); if s then return rexlib.match(s, self.compiled, ...)  end; return nil end end,
  match     = function(self) return self.ok and function(s, ...)    s=string(s, true); if s then return rexlib.match(s, self.compiled, ...)  end; return nil end end,
  matchs    = function(self) return self.ok and function(s, ...)    s=string(s, true); if s then return rexlib.match(s, self.compileds, ...) end; return nil end end,
  gsub      = function(self) return self.ok and function(s, r, ...) s=string(s, true); if s then return rexlib.gsub(s, self.compileds, r or '', ...) end; return nil end end,
  find      = function(self) return self.ok and function(s, ...)    s=string(s, true); if s then return rexlib.find(s, self.compileds, ...)  end; return nil end end,
  tfind     = function(self) return self.ok and function(s, ...)    s=string(s, true); if s then return topack(self.compiled:tfind(s, ...))  end; return nil end end,
},
__computable = {
  options   = function(self) return #self>0 and self[2] or nil end,
  pattern   = function(self) return #self>0 and self[1] or nil end,

  gsuber    = function(self) return self.ok and function(r, n) return function(s) s=string(s, true); if s then return self.gsub(s, r or '', n) end; return nil end end end,

  gmatch    = function(self) return self.ok and function(s) s=string(s, true); return s and rexlib.gmatch(s, self.compileds) or nuller end end,
  count     = function(self) return self.ok and function(s) s=string(s, true); return s and rexlib.count(s, self.compileds)  or 0 end end,
  splitz    = function(self) return self.ok and function(s) s=string(s, true); return s and call.lift(rexlib.split(s, self.compileds),nonempty) or nuller end end,
  split     = function(self) return self.ok and function(s) return self.splitz(string.null(self.trim(s))) end end,
},
__name='rex',
__tostring=function(self) return table.concat(self, ',') or '' end,
__index = function(self, k) if #self>0 then return computed(self, k) end
  if invert[k] then
    return save(self, k, setmetatable({},{
      __index=function(inv, kk) return (self[kk] or {})[k] end,
    }))
  end
  local search = function(x) return (mt(self)[x] or mt(self).__computable[x] or mt(self).__computed[k]) and true or nil end
  if search(k) then return nil end
  return save(self, k, self(pkg(self, k))) end,
__call = function(self, p, opts)
  if type(p)=='table' then p, opts = table.unpack(p) end
  if type(p)~='string' then return nil end
  assert(type(opts)=='number' or type(opts)=='string' or type(opts)=='nil', 'opts is not a number/string/nil: '..type(opts))
  if #self==0 then return setmetatable({p, opts}, getmetatable(self)) end

  local subj=p or ''
  local rv = self.tfind(subj)
  if not rv then return rv end
  if type(rv[3])=='table' then
    rv[3] = setmetatable(rv[3], getmetatable(tab))
  end
  if (type(rv[3])=='nil' or (type(rv[3])=='table' and #rv[3]==0)) and rv[1] and rv[2] then
    return subj[{rv[1], rv[2]}]
  end
  return table.nulled(table()..table.nulled(rv[3])) or nil
end,
})