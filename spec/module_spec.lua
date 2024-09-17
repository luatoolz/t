describe("module", function()
  local meta, base, sub, t
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

    assert.equal('t/def', t.module.base(t.def.auth).name)
    assert.equal('t/def', t.module.childof(t.def.auth).name)

    assert.equal('t/def/auth', meta.type(t.def.auth))
    assert.equal('t/def/auth', meta.type(t.def.auth()))
  end)
end)
