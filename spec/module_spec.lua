describe("module", function()
  local meta, module, base, sub, t
  setup(function()
    meta = require "meta"
    t = require "t"
    module = meta.module
    base = require "testdata.loader.base"
    sub = require "testdata.loader.base.sub"
  end)
  it("base", function()
    assert.equal('testdata/loader/base', module(base).name)
    assert.equal('testdata/loader/base', module(sub).name)
    assert.equal('testdata/loader/base', module(t.module.base('testdata.loader.base')).name)
    assert.equal('testdata/loader/base', module(t.module.base('testdata.loader.base.sub')).name)

    assert.equal('meta', module(t.module.base('meta')).name)
    assert.equal('meta', module(t.module.base('meta.loader')).name)

    assert.equal('meta', t.module.base('meta').base)
    assert.equal('meta', t.module.base('meta.loader').base)
  end)
end)
