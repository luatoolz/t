require "compat53"
--[[
local assert = require "luassert"
local meta = require "meta"
local no = meta.no
local t = require "t"
local is     = require "t.is"
--]]

local inspect = require "inspect"
local assert = require "luassert"
local meta = require "meta"
--local t = require "t"
local loader = require "meta.loader"
local say    = require "say"
local is     = require "t.is"
local no = meta.no

--[[
local function register(name, ...)
--print(1, name, ...)
	local arg = {...}
	local n, f, msg = nil, nil, {}
	for i=1,select('#', ...) do
		if type(arg[i])=='number' then n=arg[i] end
		if type(arg[i])=='function' then f=arg[i] end
		if type(arg[i])=='string' then msg[#msg+1]=arg[i] end
	end
--print(2, name, arg)
--	assert(n>0 and type(f)=='function')
--	assert(n>0)
	local assertion = "assertion." .. name
--	local ist = require "t.is." .. name
  local ist = f or is[name]
  _ = ist or error('error t.assert.register(' .. name .. ']')
--  local ist = f or require("t.is." .. name)

--	local ist = f
--  if not ist then
--    local is     = require "t.is"
--    ist = is[name]
--  end

--is[name]
--print(3, name, assertion, type(ist))
--	assert(ist, "no test func in is.")

--print(inspect({name=name, n=n, f=f, msg=msg, assertion=assertion, ist=ist}))

	local test = f or function(state, arguments)
--    local args = {}
--print(' TEST', #arguments, table.maxn(arguments))
--    if n~=nil and n>0 then
--      for i=1,n do
--        local v = arguments[i]
--print('  npairs ', i, v)
--        args[i]=v
----        table.insert(args, v)
--      end
--print('  r=', #args, args)
--    else
--      for i,v in ipairs(arguments) do
--print('  ipairs ', i, v)
--        args[i]=v
--      end
--    end

--    print(' arguments={ ', arguments[1], arguments[2], '}')
--    print(' #arguments=', #arguments, table.maxn(arguments), getmetatable(arguments))
--    print(' #args=     ', #args, table.maxn(args), getmetatable(args))
--    local is     = require "t.is"
--    local ist = is[name]

--		print(1, name)
--		local a = table{}
--		for i=1,n do a[i]=arguments[i] end

--    if n~=nil and n>0 then
--      if #arguments~=n then error('error: incorrect #arguments in t.assert.register(' .. name .. '], should be ' .. tostring(n) .. ', got ' .. tostring(#arguments)) end
---    end
--    local n = n or table.maxn(arguments)
		local rv = ist(table.unpack(arguments, 1, n or table.maxn(arguments)))
--print(ist, rv)
		return rv
--  	local x = arguments[1]
--  	return x==nil or tonumber(x)==0 or tostring(x)=="" or (type(x)=='table') and next(x)==nil or x==false
	end
--print(4)
	if #msg>0 then say:set(assertion .. ".positive", msg[1]) end
	if #msg>1 then say:set(assertion .. ".negative", msg[2]) end
--print(5)
--print('  XXXXXXXXXXXXXXXX assert: register', '(', name, ')')
  local reg = assert:register("assertion", name, test,
                assertion .. ".positive",                                 
                assertion .. ".negative")
--	print(' register=', reg, type(reg))
--print(6)
	return test
end
--]]

for k,v in pairs(loader(..., true)) do
--  print(k, table.unpack(v), inspect(is[k]))
	no.asserts(k, table.unpack(v), is[k])
end

return assert
