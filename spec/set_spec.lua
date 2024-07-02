describe("set", function()
  local t, set
  setup(function()
    t = require "t"
    set = t.set
  end)
  it("__add + __sub", function()
    assert.same(set('b') + 'c', set('a', 'b', 'c')-'a')
  end)
  it("__pairs", function()
    assert.equal(set(table.map(set('a', 'b', 'c'))), set('a', 'b', 'c'))
  end)
  describe("create", function()
    it("nil", function()
      assert.is_table(set())
      assert.is_table(set({}))
      assert.same(set(), set({}))
      assert.is_nil(set()['a'])
      assert.is_nil(set()[''])
      assert.is_nil(set()[0])
      assert.is_nil(set()[nil])
    end)
    it("nil operations", function()
      assert.equal(set(), set() .. set())
      assert.equal(set(), set() + set())
      assert.equal(set(), set() - set())
      assert.equal(set(), set() * set())
      assert.equal(true, set() <= set())
      assert.equal(true, set() >= set())
      assert.equal(true, set() == set())
    end)
    it("1+nil operations", function()
      assert.equal(set('a'), set('a') + set())
      assert.equal(set('a'), set('a') + set('a'))
      assert.equal(set('a'), set() + set('a'))
      assert.equal(set('a'), set('a') .. set())
      assert.equal(set('a'), set('a') .. set('a'))
      assert.equal(set('a'), set() .. set('a'))
      assert.equal(set('a'), set('a') - set())
      assert.equal(set(), set('a') - set('a'))
      assert.equal(set(), set() - set('a'))
      assert.equal(set(), set('a') * set())
      assert.equal(set('a'), set('a') * set('a'))
      assert.equal(set(), set() * set('a'))
    end)
    it("1+1+nil operations", function()
      assert.equal(set('a', 'b'), set('a') + set('b'))
      assert.equal(set('a', 'b'), set('b') + set('a'))
      assert.equal(set('a', 'b'), set('a') .. set('b'))
      assert.equal(set('a', 'b'), set('b') .. set('a'))
      assert.equal(set('a', 'b'), set('a', 'b') - set())
      assert.equal(set('b'), set('a', 'b') - set('a'))
      assert.equal(set(), set('a', 'b') - set('a', 'b'))
      assert.equal(set(), set('a') * set('b'))
      assert.equal(set('a', 'b'), set('a', 'b') * set('a', 'b'))
    end)
    it("2+ operations", function()
      assert.equal(set('a', 'b'), set('a', 'b') + set('b', 'a'))
      assert.equal(set('a', 'b'), set('b', 'a') + set('a', 'b'))
      assert.equal(set('a', 'b'), set('a', 'b') .. set('b', 'a'))
      assert.equal(set('a', 'b'), set('b', 'a') .. set('a', 'b'))
      assert.equal(set('a', 'b'), set('a', 'b') - set())
      assert.equal(set('b'), set('a', 'b') - set('a'))
      assert.equal(set(), set('a', 'b') - set('a', 'b'))
      assert.equal(set('a', 'b'), set('a', 'b') * set('b', 'a'))
    end)
  end)
  it("regular operations", function()
    assert.equal(set(table.map(set('a', 'b', 'c'))), set('a', 'b', 'c'))
    assert.is_function(t.fn.noop)
    assert.equal(getmetatable(set).__item, t.fn.noop)
    assert.equal('a', set('a')['a'])
    assert.is_table(set('a', 'b'))
  end)
  it("of", function()
    local nums = set:of(tonumber)
    assert.is_table(nums)
    assert.equal(nums(1, 7, 88, 1), nums('1', '7', '88'))
  end)
  it("compare", function()
    assert.is_true(set('a', 'b', 'c') <= set('a', 'b', 'c', 'd'))
    assert.is_true(set('a', 'd', 'b', 'c') <= set('a', 'b', 'c', 'd'))
    assert.is_true(set('a', 'd', 'b', 'c') == set('a', 'b', 'c', 'd'))
  end)
  it("map", function()
    local nums = set:of(tonumber)
    assert.equal(nums('2', '14', '176'), nums('1', '7', '88') * function(x) return tonumber(x)*2 end)
    assert.equal(nums(2, 14, 176), nums('2', '14', '176'))
  end)
  it("filter", function()
    local nums = set:of(tonumber)
    assert.equal(nums(88), nums('1', '7', '88') % function(x) return tonumber(x)>50 end)
  end)
end)
