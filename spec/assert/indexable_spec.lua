describe("assert indexable", function()
	local t, meta
	setup(function()
    meta = require "meta"
		t = require "t"
	end)
  it("positive", function()
    assert.indexable(table)
    assert.indexable(t)
    assert.indexable(t.is)
    assert.indexable(meta)
    assert.indexable(meta.loader)
  end)
  it("negative", function()
    assert.not_indexable("some")
    assert.not_indexable(true)
    assert.not_indexable({7})
    assert.not_indexable(1)
    assert.not_indexable("1")
    assert.not_indexable(table.remove)
  end)
  it("negative", function()
    assert.not_indexable(nil)
    assert.not_indexable()
  end)
end)
