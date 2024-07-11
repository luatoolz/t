describe("t.type", function()
  local meta, t, is, tt
  setup(function()
    meta = require "meta"
    t = require "t"
    is = require "t.is"
    tt = t.type
  end)
  it("type", function()
    assert.equal('meta/loader', tt(meta.loader))
    assert.equal('meta', tt(meta))
    assert.equal('t/array', tt(t.array))
    assert.equal('t/array', tt(t.array()))
    assert.equal('t/set', tt(t.set))
    assert.equal('t/set', tt(t.set()))
  end)
end)
