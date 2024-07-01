describe("assert loader", function()
	local t, meta
	setup(function()
    meta = require "meta"
		t = require "t"
	end)
  it("positive", function()
    assert.loader(meta)
    assert.loader(t)
    assert.loader(meta.loader)
  end)
  it("negative", function()
    assert.not_loader("some")
    assert.not_loader(true)
    assert.not_loader({7})
    assert.not_loader(1)
    assert.not_loader("1")
    assert.not_loader(table)
    assert.not_loader(table.remove)
  end)
  it("nil", function()
    assert.not_loader(nil)
    assert.not_loader()
  end)
end)
