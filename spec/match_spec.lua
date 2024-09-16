describe("match", function()
  local t
  setup(function()
    t = require "t"
  end)
  it("match", function()
--    assert.equal('/init.lua', t.match.luafiles('x/pic.same/init.lua'))
    assert.equal('x/pic.same', t.strip.luafiles('x/pic.same/init.lua'))
    assert.equal('x/pic.same/module', t.strip.luafiles('x/pic.same/module.lua'))

    assert.equal('module', t.match.basename('x/pic.same/module'))
  end)
end)
