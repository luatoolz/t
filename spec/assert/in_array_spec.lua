describe("assert in_array", function()
	setup(function() require "t" end)
  it("positive", function()
		assert.in_array("two", {"one", "two", "three", "four"})
		assert.in_array(2, {1, 2, 3, 4})
	end)
  it("negative", function()
		assert.not_in_array("seven", {"one", "two", "three", "four"})
	end)
  it("nil in array", function()
		assert.in_array(nil, {"1", "2", nil, "3", "4"})
		assert.in_array(nil, {1, nil, 3})
		assert.in_array(nil, {nil, 2})
	end)
  it("nil not in array", function()
		assert.not_in_array(nil, {"one", "two", "three", "four"})
		assert.not_in_array(nil, {})
	end)
  it("nil", function()
		assert.has_error(function() assert.in_array() end)
		assert.has_error(function() assert.in_array(nil) end)
		assert.has_error(function() assert.in_array("seven") end)
		assert.has_error(function() assert.in_array("seven", nil) end)
	end)
end)
