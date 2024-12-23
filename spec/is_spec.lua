describe("is", function()
  local meta, t, is, has
  setup(function()
    meta = require "meta"
    t = require "t"
    is = t.is
    has = is.has
  end)
  it("init.d", function()
      assert.not_nil(t['init.d'])
  end)
  it("has.tonumber", function()
      assert.is_true(has.tonumber(meta.mcache.loader))
  end)
end)