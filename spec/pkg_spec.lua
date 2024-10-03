describe("pkg", function()
  local t, meta, module, loader
  setup(function()
    meta = require "meta"
    t = require "t"
    module = meta.module
    loader = meta.loader
  end)
  it("pkg", function()
    assert.equal(loader(module('meta').base), t.pkg('meta'))
    assert.equal(loader(module('meta.loader').base), t.pkg('meta.loader'))
    assert.equal(loader(module('testdata/loader/base').base), t.pkg('testdata/loader/base'))
    assert.equal(loader(module('testdata/loader/base/sub').base), t.pkg('testdata/loader/base'))
    assert.equal(loader(module('testdata/loader/base').base), t.pkg('testdata/loader/base/sub'))
  end)
  it("pkgname", function()
    assert.equal(module('meta').base, t.pkgname('meta'))
    assert.equal(module('meta.loader').base, t.pkgname('meta.loader'))
    assert.equal(module('testdata/loader/base').base, t.pkgname('testdata/loader/base'))
    assert.equal(module('testdata/loader/base/sub').base, t.pkgname('testdata/loader/base'))
    assert.equal(module('testdata/loader/base').base, t.pkgname('testdata/loader/base/sub'))
  end)
end)
