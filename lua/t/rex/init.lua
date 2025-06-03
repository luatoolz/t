local rexlib = require 'rex_pcre2'
local t = require 't'
local pkg = t.pkg(...)
local mt = t.gmt
local call = t.call

local computed = t.mt.computed

local tab = table()
local default = 'i' -- imsxU
local config  = rexlib.config()
local make    = rexlib.maketables()
mt(make).__metatable = nil
_ = config

local function nuller(...) return nil end
local function topack(...) return table.nulled(table(...)) or nil end
local function nonempty(s,l) return (s or type(l)~='nil') and s or nil end

return setmetatable({},{
__computed = {
  iscomplex = function(self) return self.isindexed or self.isnamed end,
  isindexed = function(self) local p=self.pattern;  return (type(p)=='string' and (p:match('[^%\\]%([^%?]') or p:match('^%([^%?]'))) and true or nil end,
  isnamed   = function(self) local p=self.pattern;  return (type(p)=='string' and p:match('%(%?%<[%w_]+%>')) and true or nil end,
  iswhole   = function(self) local p=self.pattern;  return (type(p)=='string' and p:match('^%^.+%$$')) and true or nil end,

  patterns  = function(self) local p=self.pattern;  return type(p)=='string' and p:gsub('^%^',''):gsub('%$$','') or nil end,
  startp    = function(self) local p=self.patterns; return type(p)=='string' and '^'..p or nil end,
  endp      = function(self) local p=self.patterns; return type(p)=='string' and p..'$' or nil end,

  compiled  = function(self) return rexlib.new(self.pattern,  self.options or default) end,
  compileds = function(self) return rexlib.new(self.patterns, self.options or default) end,

  ltrim     = function(self) return function(subj) return subj and rexlib.gsub(subj, self.startp, '') or nil end end,
  rtrim     = function(self) return function(subj) return subj and rexlib.gsub(subj, self.endp, '') or nil end end,
  trim      = function(self) return function(subj) return subj and rexlib.gsub(rexlib.gsub(subj, self.startp, ''), self.endp, '') or nil end end,

  match     = function(self) return function(subj, ...) local p=self.compiled;  if p then return rexlib.match(subj or '', p, ...) end; return nil end end,
  matchs    = function(self) return function(subj, ...) local p=self.compileds; if p then return rexlib.match(subj or '', p, ...) end; return nil end end,
  gsub      = function(self) return function(subj, repl, ...) local p=self.compileds;  if (p and subj) then return rexlib.gsub(subj, p, repl or '', ...) end; return nil end end,
  find      = function(self) return function(subj, ...) local p=self.compileds; if p then return rexlib.find(subj or '', p, ...) end; return nil end end,
  tfind     = function(self) return function(subj, ...) local p=self.compileds; if p then return topack(p:tfind(subj or '', ...)) end; return nil end end,
},
__computable = {
  options   = function(self) return #self>0 and self[2] or nil end,
  pattern   = function(self) return #self>0 and self[1] or nil end,

  gmatch    = function(self) local p=self.compileds; return function(subj) return type(subj)=='string' and rexlib.gmatch(subj, p) or nuller end end,
  count     = function(self) local p=self.compileds; return function(subj) return type(subj)=='string' and rexlib.count(subj, p)  or 0 end end,
  split     = function(self) local p=self.compileds; return function(subj) return type(subj)=='string' and call.lift(rexlib.split(subj, p),nonempty) or nuller end end,
  splitz    = function(self) return function(subj) return self.split(string.null(self.trim(subj))) end end,
},
__name='rex',
__tostring=function(self) return table.concat(self, ',') end,
__index = function(self, k) return #self>0 and computed(self, k) or table.save(self, k, self(pkg(self, k))) end,
__call = function(self, p, opts)
  if type(p)=='table' then p, opts = table.unpack(p) end
  if type(p)=='nil' then return nil end
  assert(type(p)=='string', 'pattern is not a string: '..type(p))
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