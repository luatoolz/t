describe("boolean", function()
  local t
  setup(function()
    t = require "t"
  end)
  it("toboolean", function()
    assert.callable(toboolean)
    assert.is_true(toboolean(7))
    assert.is_false(toboolean(0))
  end)
end)
