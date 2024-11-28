describe("is.integer", function()
  local t, is
  setup(function()
    t = require "t"
    is = t.is
  end)
  it("is.integer", function()
    assert.is_table(is)
    assert.not_nil(is.integer)
    assert.is_true(is.integer(77))
  end)
end)