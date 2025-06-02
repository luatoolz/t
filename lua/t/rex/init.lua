local rexlib = require 'rex_pcre2'
local t = require 't'
local pkg = t.pkg(...)
local mt = t.gmt

local tab = table()
local default = 'i'
local config  = rexlib.config()
local make    = rexlib.maketables()
mt(make).__metatable = nil
_ = config
local some = rexlib.new('some')

mt(some, {
__call=function(self, subj) subj=subj or ''
  local rv = table(table.pack(self:tfind(subj)))
  assert(type(rv)=='table', 'await table, got '..type(rv))
  if type(rv[3])=='table' then
    rv[3] = setmetatable(rv[3], getmetatable(tab))
  end
  if (type(rv[3])=='nil' or (type(rv[3])=='table' and #rv[3]==0)) and rv[1] and rv[2] then
    return subj[{rv[1], rv[2]}]
  end
  return table.nulled(table()..table.nulled(rv[3])) or nil
end,
}, {__metatable=false})

return pkg ^ function(x)
  if type(x)=='string' then return rexlib.new(x, default) end
  if type(x)=='table' then return rexlib.new(table.unpack(x)) end
  return nil
end

--[[
https://rrthomas.github.io/lrexlib/manual.html#match

flags
new
  rex.new (patt, [cf], [larg...])

match
  rex.match (subj, patt, [init], [cf], [ef], [larg...])
  r:match (subj, [init], [ef])

find
  rex.find (subj, patt, [init], [cf], [ef], [larg...])
  r:find (subj, [init], [ef])

gmatch
  rex.gmatch (subj, patt, [cf], [ef], [larg...])

gsub
  rex.gsub (subj, patt, repl, [n], [cf], [ef], [larg...])

split
  rex.split (subj, sep, [cf], [ef], [larg...])

count
  rex.count (subj, patt, [cf], [ef], [larg...])

tfind
  r:tfind (subj, [init], [ef])

exec
  r:exec (subj, [init], [ef])

--]]
