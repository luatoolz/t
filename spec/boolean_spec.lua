describe("boolean", function()
  local bool
  setup(function() bool = require "t.boolean" end)
  it("toboolean", function()
    assert.is_function(bool)
    assert.is_true(bool(7))
    assert.is_false(bool(0))
  end)
end)
