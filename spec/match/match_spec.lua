describe("match", function()
	local t, match
	setup(function()
    t = require "t"
    match = t.match
	end)
  it("meta", function()
    assert.is_table(match)
    assert.is_function(select(2, next(match)))
  end)
end)