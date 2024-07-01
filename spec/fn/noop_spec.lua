describe("noop", function()
  local noop
  setup(function() noop = require "t.fn.noop" end)
  it("scope", function()
    assert.equal(7, noop(7))
    assert.equal("xyz", table.concat({noop("x", "y", "z")}))
    assert.same({"x", "y", "z"}, {noop("x", "y", "z")})
  end)
end)
