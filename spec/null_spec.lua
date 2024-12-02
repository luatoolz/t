describe("null", function()
	local t, is, null, export
	setup(function()
    t = require "t"
    is = t.is
    null = t.null
    export = t.exporter
	end)
  it("meta", function()
    assert.truthy(is)
    assert.truthy(is.null)
    assert.truthy(is.callable(is.null))

    assert.is_table(null)
    assert.is_table(getmetatable(null))
  end)
  it("positive", function()
    assert.is_true(is.null(null))
    assert.is_true(is.null(nil))

    assert.equal(null, null())
    assert.is_nil(null.any)
    assert.is_nil(export(null))
  end)
  it("negative", function()
    assert.is_nil(is.null({}))
    assert.is_nil(is.null(string.lower))
    assert.is_nil(is.null(1))
    assert.is_nil(is.null(true))
    assert.is_nil(is.null(false))
    assert.is_nil(is.null('some'))
    assert.is_nil(is.null(''))
  end)
  it("nil", function()
    assert.is_true(is.null(nil))
    assert.is_true(is.null())
  end)
end)