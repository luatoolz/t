describe("module", function()
  local meta, module, loader, base, sub, t
  setup(function()
    meta = require "meta"
    t = require "t"
    module = meta.module
    loader = meta.loader
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
  it("pkg", function()
    assert.equal(t.pkg('meta'), loader(module('meta').base))
    assert.equal(t.pkg('meta.loader'), loader(module('meta.loader').base))
    assert.equal(t.pkg('testdata/loader/base'), loader(module('testdata/loader/base').base))
    assert.equal(t.pkg('testdata/loader/base'), loader(module('testdata/loader/base/sub').base))
    assert.equal(t.pkg('testdata/loader/base/sub'), loader(module('testdata/loader/base').base))
  end)
end)
