describe("assert sametype", function()
  local t, meta
	setup(function()
    t = require "t"
    meta = require "meta"
  end)
  it("positive", function()
		assert.sametype(nil, nil)
		assert.sametype(function() end, string.sub)
		assert.sametype(2, 3)
		assert.sametype("two", "one")
		assert.sametype({}, {"one", "two", "three", "four"})
		assert.sametype(meta.loader("t"), t)
		assert.sametype(meta("t"), t)
		assert.sametype(meta, meta.loader('meta'))
		assert.sametype()
	end)
  it("negative", function()
    assert.not_sametype("seven", 7)
		assert.not_sametype("seven", {})
  end)
  it("nils", function()
		assert.not_sametype(nil, "one")
		assert.not_sametype("one", nil)
		assert.sametype(nil, nil)
		assert.sametype(nil)
		assert.sametype()
	end)
end)
