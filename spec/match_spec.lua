describe("match", function()
  local t, is
  setup(function()
    t = require "t"
    is = t.is
  end)
  it("match", function()
--    assert.equal('/init.lua', t.match.luafiles('x/pic.same/init.lua'))
    assert.equal('x/pic.same', t.strip.luafiles('x/pic.same/init.lua'))
    assert.equal('x/pic.same/module', t.strip.luafiles('x/pic.same/module.lua'))

    assert.equal('module', t.match.basename('x/pic.same/module'))

    assert.equal('t/storage/mongo', t.match.modbase('t/storage/mongo/connection'))
    assert.equal('t.storage.mongo', t.match.modbase('t.storage.mongo.connection'))
  end)
  it("md5", function()
    local hash = 'bf99f3a50b0f254517402d909c8d0358'
    assert.equal(t.matcher.md5, t.matcher.x32)
    assert.is_function(t.match.x32)
    assert.is_function(t.match.md5)

    assert.equal(hash, t.match.x32(hash))
    assert.equal(hash, t.match.md5(hash))

    assert.equal(hash, is.match.x32(hash))
    assert.equal(hash, is.match.md5(hash))

    assert.equal(hash, is.match.md5(hash))

    assert.md5(hash)
  end)
  it("id", function()
    assert.id('a')
    assert.id('0')
    assert.id('_')

    assert.id('ab9.x')
    assert.id('ab.a')
    assert.id('a.99')
    assert.id('a.x_9')
    assert.id('a__89.q')

    assert.not_id('.')
    assert.not_id('!')
    assert.not_id('@')
    assert.not_id('#')
    assert.not_id('$')
    assert.not_id('%')
    assert.not_id('^')
    assert.not_id('&')
    assert.not_id('*')
    assert.not_id('(')
    assert.not_id(')')
    assert.not_id('+')
    assert.not_id('=')
    assert.not_id('~')
    assert.not_id('`')
    assert.not_id('|')
    assert.not_id('й')
  end)
end)
