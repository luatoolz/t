describe("failed", function()
  local t, is, e
  setup(function()
    t = require "t"
    is = t.is
    e = t.failed
    local _ = t.failed ^ false
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

    assert.equal(false, toboolean(e(nil, 'e')))
    assert.equal(false, toboolean(e(nil, 'e', 'some')))

    assert.truthy(is.failed(e(nil, 'e')))
  end)
end)
