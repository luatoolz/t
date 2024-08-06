describe("t.type", function()
  local meta, t, tt
  setup(function()
    meta = require "meta"
    t = require "t"
    tt = t.type
  end)
  it("type", function()
    assert.equal('meta/loader', tt(meta.loader))
    assert.equal('meta', tt(meta))
		assert.is_table(t.array)
    assert.equal('t/array', tt(t.array))
    assert.equal('t/array', tt(t.array()))
    assert.equal('t/set', tt(t.set))
    assert.equal('t/set', tt(t.set()))
    assert.equal('t/is', tt(t.is))
    assert.equal('t', tt(t))
  end)
end)
