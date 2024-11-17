describe("failed", function()
  local t, is, to, e
  setup(function()
    t = require "t"
    is, to, e = t.is, t.to, t.failed ^ false
  end)
  it("meta", function()
    assert.callable(e)
  end)
  it("ok", function()
    assert.is_table(e)
    assert.equal('ok', e('ok'))
    assert.equal('ok', e('ok', nil))
    assert.equal('ok', e('ok', nil, 888))
    assert.equal('ok', e('ok', 'some'))
  end)
  it("failed", function()
    assert.same({'e'}, e(nil, 'e'))
    assert.same({'e', 'some'}, e(nil, 'e', 'some'))

    assert.equal('e', tostring(e(nil, 'e')))
    assert.equal('e some', tostring(e(nil, 'e', 'some')))

    assert.equal(false, to.boolean(e(nil, 'e')))
    assert.equal(false, to.boolean(e(nil, 'e', 'some')))

    assert.truthy(is.failed(e(nil, 'e')))
  end)
end)