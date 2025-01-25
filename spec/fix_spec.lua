describe("fix", function()
	local t, is, fix
	setup(function()
    t = require "t"
    is = t.is
    fix = t.fix
	end)
  it("meta", function()
    assert.truthy(is)
    assert.truthy(is.callable(fix))

    assert.is_table(fix)
    assert.is_table(getmetatable(fix))
  end)
  it("positive", function()
    local o=fix({a=function(v,k,obj,objkey) return false end, b=function(v,k,obj,objkey) return v*2 end})
    assert.same({a=false, b=154}, o({a=true, b=77}))
    assert.same({a=false, b=0}, o({a=34, b=0}))
  end)
end)