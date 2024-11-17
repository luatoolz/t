describe("object", function()
  local t, meta, object, cache
  setup(function()
    t = require "t"
    meta = require "meta"
    object = t.object
    cache = meta.cache
  end)
  it("base", function()
    if next(object) then
      assert.equal('___', object.___)
      assert.equal('__', object.__)
      assert.equal('_', object._)
    end
  end)
  it("testdata loader", function()
    local o = require 'testdata.init4'
    assert.is_table(o, 'mt is not a function')
    assert.equal('okok', o.data)
    assert.equal('ax', o.a.x.name)
  end)
  it("new loader", function()
    local o = object():loader('testdata.init4'):factory({q='init4'})
    assert.is_table(o, 'is object')
    assert.equal('init4', o.q)
    assert.is_table(cache.loader[o])
    assert.equal('by', o.b.y.name)
  end)
  it("properties", function()
    local o = object({x='any', z=function(x) return (tonumber(x) or 1)*4  end}):factory()
    assert.equal('any', o.x)
    assert.equal(40, o.z(10))
    assert.is_nil(o.tt)
  end)
  it("computed({})", function()
    local o = object({x='any', z=function(x) return (tonumber(x) or 1)*4  end}):computed({w=function(self) return self.x .. ' NOT ANY' end}):factory()
    assert.equal('any', o.x)
    assert.equal(40, o.z(10))
    assert.is_nil(rawget(o, 'w'))
    assert.equal('any NOT ANY', o.w)
    assert.equal('any NOT ANY', rawget(o, 'w'))
  end)
  it("__computed={}", function()
    local o = object({x='any', z=function(x) return (tonumber(x) or 1)*4  end}):computed({w=function(self) return self.x .. ' NOT ANY' end})
    o.__computed = {w=function(self) return self.x .. ' NOT ANY OTHER' end}
    o=o:factory()
    assert.equal('any', o.x)
    assert.equal(40, o.z(10))
    assert.is_nil(rawget(o, 'w'))
    assert.equal('any NOT ANY OTHER', o.w)
    assert.equal('any NOT ANY OTHER', rawget(o, 'w'))
  end)
  it("computable({})", function()
    local o = object({x='any', z=function(x) return (tonumber(x) or 1)*4  end}):computable({w=function(self) return self.x .. ' NOT ANY' end}):factory()
    assert.equal('any', o.x)
    assert.equal(40, o.z(10))
    assert.is_nil(rawget(o, 'w'))
    assert.equal('any NOT ANY', o.w)
    assert.is_nil(rawget(o, 'w'))
  end)
  it("__computable={}", function()
    local o = object({x='any', z=function(x) return (tonumber(x) or 1)*4  end}):computable({w=function(self) return self.x .. ' NOT ANY' end})
    o.__computable={w=function(self) return self.x .. ' NOT ANY 11' end, e=function(self) return self.x .. ' NOT ANY 22' end}
    o=o:factory()
    assert.equal('any', o.x)
    assert.equal(40, o.z(10))
    assert.is_nil(rawget(o, 'w'))
    assert.equal('any NOT ANY 11', o.w)
    assert.is_nil(rawget(o, 'w'))
    assert.is_nil(rawget(o, 'e'))
    assert.equal('any NOT ANY 22', o.e)
    assert.is_nil(rawget(o, 'e'))
  end)
  it("__comput...w+e=", function()
    local o = object({x='any', z=function(x) return (tonumber(x) or 1)*4  end})
    o.__computable.w=function(self) return self.x .. ' NOT ANY 11' end
    o.__computed.e=function(self) return self.x .. ' NOT ANY 22' end
    o=o:factory()
    assert.equal('any', o.x)
    assert.equal(40, o.z(10))
    assert.is_nil(rawget(o, 'w'))
    assert.equal('any NOT ANY 11', o.w)
    assert.is_nil(rawget(o, 'w'))
    assert.is_nil(rawget(o, 'e'))
    assert.equal('any NOT ANY 22', o.e)
    assert.equal('any NOT ANY 22', rawget(o, 'e'))
  end)
  it("mt", function()
    local o = object({x='any'}):mt({__tostring=function(self) return self.x .. ' with any' end})
    o.__call=function(self) return 888 end
    o=o:factory()
    assert.equal('any', o.x)
    assert.equal('any with any', tostring(o))
    assert.is_nil(o.tt)
    assert.equal(888, o())
  end)
  it("imports", function()
    local o = object({x='any'}):imports({named=function(x) return type(x)~='string' or string.upper(x) end}):factory()
    assert.equal('any', o.x)
    o.named='any test'
    assert.equal('ANY TEST', rawget(o, 'named'))
    assert.equal('ANY TEST', o.named)
  end)
  it("__imports", function()
    local o = object({x='any'})
    o.__imports={named=function(x) return type(x)~='string' or string.upper(x) end}
    o=o:factory()
    assert.equal('any', o.x)
    o.named='any test'
    assert.equal('ANY TEST', rawget(o, 'named'))
    assert.equal('ANY TEST', o.named)
  end)
  describe("load order", function()
    it("factory", function()
      local o = require 'testdata.factory'
      assert.is_table(o, 'mt is not a function')
      assert.equal('factory', o.ok)
    end)
    it("preindex", function()
      local o = require 'testdata.preindex'
      assert.equal('preindex', o.ok)
    end)
    it("mt", function()
      local o = require 'testdata.mt'
      assert.equal('mt', o.ok())
    end)
    it("computable", function()
      local o = require 'testdata.computable'
      assert.equal('computable', o.ok)
    end)
    it("computed", function()
      local o = require 'testdata.computed'
      assert.equal('computed', o.ok)
    end)
    it("loader", function()
      local o = require 'testdata.loader'
      assert.equal('loader', o.ok)
    end)
    it("postindex", function()
      local o = require 'testdata.postindex'
      assert.equal('postindex', o.ok)
    end)
  end)
end)