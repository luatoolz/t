describe("rex", function()
  local t, is, rex, lib
  setup(function()
    t   = require 't'
    is  = t.is
    rex = t.rex
    lib = require 'rex_pcre2'
  end)
  it("meta", function()
    assert.truthy(is)
    assert.callable(lib.new)
  end)
  it("new", function()
    local re = lib.new('^(?<first>__[\\w_]+)\\s*(?<last>[a-z0-9]+)?')
    assert.same({'__call', 'name1', first='__call', last='name1'}, re('__call name1'))
    assert.is_nil(re(''))

    re = lib.new('^__[\\w_]+\\s+[\\w_0-9]+$')
    assert.equal('__call name2', re('__call name2'))

    re = lib.new('^__[\\w_]+\\s+\\w+$')
    assert.equal('__call name2', re('__call name2'))

    re = lib.new('^(__[\\w_]+\\s+\\w+)$')
    assert.same({'__call name3'}, re('__call name3'))

    re = lib.new('^(__[\\w_]+)\\s+(\\w+)$')
    assert.same({'__call', 'name4'}, re('__call name4'))

    local flags = {}
    lib.flags(flags)
    assert.equal(8, flags.CASELESS)

    re = lib.new('^(__[\\w_]+)\\s+([a-z]+)?', 'ix')
    assert.same({'__call', 'NAME'}, re('__call NAME'))
  end)
  it("gmatch", function()
    for v in lib.gmatch('__index', rex.mtname) do
      assert.same('__index', v)
    end
  end)
  it("matcher", function()
    assert.same('__index', rex.mtname('__index'))
  end)
  it("__mod/__mul", function()
    assert.equal(table('__index'), table('__index')*rex.mtname)
    assert.equal(table('__index'), table('__index')%rex.mtname)
  end)
end)