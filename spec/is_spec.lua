describe("t.is", function()
  local meta, t, is
  setup(function()
    meta = require "meta"
    t = require "t"
    is = require "t.is"
  end)
  it("tonumber", function()
    assert.equal(0, tonumber(0))
    assert.equal(0, tonumber('0'))
    assert.equal(nil, tonumber(''))
    assert.equal(nil, tonumber('ui'))
    assert.equal(nil, tonumber(nil))
  end)
  it("nil", function()
    assert.is_true(is['nil'](nil))
    assert.is_true(is.Nil(nil))
    assert.is_true(is.null(nil))
    assert.is_true(is.null())
  end)
  it("number", function() assert.is_true(is.number(7)) end)
  it("string", function() assert.is_true(is.string("a")) end)
  it("file", function() assert.is_file(io.stdin) end)
  it("table", function() assert.is_true(is.table({88, 99})) end)
  it("boolean", function() assert.is_true(is.boolean(true)) end)
  it("func", function()
    assert.is_true(is.func(table.remove))
    assert.is_true(is['function'](table.remove))
  end)
  it("callable", function()
    assert.is_true(is.callable(table.remove))
    assert.is_true(is.callable(table))
    assert.is_true(is.callable(meta.loader))
  end)
  it("iterable", function()
    assert.is_true(is.iterable(table))
    assert.is_true(is.iterable(meta.loader))
  end)
  it("indexable", function()
    assert.is_true(is.indexable(table))
    assert.is_true(is.indexable(meta))
  end)
  it("loader", function()
    assert.is_callable(is.loader)
    assert.is_false(is.table(meta))
    assert.is_true(is.loader(meta))
    assert.is_true(is.loader(meta.loader))
  end)
  it("stringer", function()
    assert.is_callable(is.stringer)
    assert.is_stringer('')
    assert.is_stringer(meta)
    assert.is_stringer(meta.loader)
  end)
  it("require", function()
    assert.is_table(is)
    assert.not_nil(is.integer)
    assert.truthy(is.integer(77))
  end)
  it("mtequal", function()
    assert.mtequal(meta, meta.loader)

    local __item = getmetatable(t.set).__item
    assert(__item == t.fn.noop or __item==nil)

    assert.mtequal(t.set, t.set:of(tostring), {'__item'})
    assert.mtequal(t.set, t.set:of(tonumber), {'__item'})

    assert.is_true(is.mtequal(t.set, t.set:of(tonumber), {'__item'}))
    assert.is_true(is.of.set(t.set:of(tonumber)))
    assert.of_set(t.set:of(tonumber))

    assert.is_true(is.mtequal(t.array, t.array:of(tonumber), {'__item'}))
    assert.is_true(is.of.array(t.array:of(tostring)))
    assert.of_array(t.array:of(tostring))
  end)
  it("bulk", function()
    assert.not_is_bulk()
    assert.not_is_bulk(nil)
    assert.not_is_bulk(1)
    assert.not_is_bulk("")
    assert.not_is_bulk(true)
    assert.not_is_bulk(false)
    assert.not_is_bulk(string.upper)
    assert.not_is_bulk({})

    assert.is_bulk(t.set)
    assert.is_bulk(t.set())
    assert.is_bulk(t.set:of(tostring))
    assert.is_bulk(t.set:of(tostring)())
    assert.is_bulk({"x"})
    assert.is_bulk({"x", "y"})
    assert.is_bulk(t.array)
    assert.is_bulk(t.array())
  end)
  it("eq", function()
      assert.eq()
      assert.eq(nil)
      assert.eq(nil, nil)
      assert.eq('', '')
      assert.eq(3, 3)
      assert.eq(true, table({x=1}))
      assert.eq('x', 'x')
      assert.eq({a=1}, {a=1})
      assert.eq({a=1, b={}}, {a=1, b={}})
      assert.eq({a=1, b={c={777}}}, {a=1, b={c={777}}})
      assert.not_eq({a=1}, {a='1'})
      assert.eq({'a'}, {'a'})
      assert.not_eq({'a'}, {'b'})

      local a = setmetatable({}, {__eq=function() return true end})
      local b = setmetatable({}, {__eq=function() return false end})
      assert.eq(a, b)
      assert.not_eq(b, a)
  end)
end)
