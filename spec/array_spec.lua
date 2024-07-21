describe("array", function()
  local t, array
  setup(function()
    t = require "t"
    array = t.array
  end)
  it("__pairs", function()
    assert.equal(array('a', 'b', 'c'), array('a', 'b', 'c'))
    assert.equal(array('a', 'b', 'c'), array(table.map(array('a', 'b', 'c'))))
    assert.equal(array('a', 'b', 'c'), array(table.map(array('a', 'b', 'c'))))
    assert.equal(array('a', 'b', 'c'), table.map(array('a', 'b', 'c')))
  end)
  describe("create", function()
    it("nil", function()
      assert.is_table(array())
      assert.is_table(array({}))
      assert.same(array(), array({}))
      assert.is_nil(array()['a'])
      assert.is_nil(array()[''])
      assert.is_nil(array()[0])
      assert.is_nil(array()[1])
      assert.is_nil(array()[nil])
    end)
    it("nil operations", function()
      assert.equal(array(), array() .. array())
      assert.equal(array(), array() + array())
      assert.equal(array(), array() - array())
      assert.equal(array(), array() * nil)
      assert.equal(true, array() == array())
    end)
    it("1+nil operations", function()
      assert.equal(array('a'), array('a') + array())
      assert.equal(array('a', 'a'), array('a') + array('a'))
      assert.equal(array('a'), array() + array('a'))
      assert.equal(array('a'), array('a') .. array())
      assert.equal(array('a', 'a'), array('a') .. array('a'))
      assert.equal(array('a'), array() .. array('a'))
      assert.equal(array('a'), array('a') - array())
      assert.equal(array(), array('a') - array(1))
      assert.equal(array('a'), array('a') * array())
      assert.equal(array('a'), array('a') * array('a'))
      assert.equal(array(), array() * array('a'))
    end)
    it("1+1+nil operations", function()
      assert.equal(array('a', 'b'), array('a') + array('b'))
      assert.equal(array('b', 'a'), array('b') + array('a'))
      assert.equal(array('a', 'b'), array('a') .. array('b'))
      assert.equal(array('b', 'a'), array('b') .. array('a'))
      assert.equal(array('a', 'b'), array('a', 'b') - array())
      assert.equal(array('b'), array('a', 'b') - array(1))
      assert.equal(array('a'), array('a', 'b') - array(2))
    end)
    it("2+ operations", function()
      assert.equal(array('a', 'b', 'b', 'a'), array('a', 'b') + array('b', 'a'))
      assert.equal(array('b', 'a', 'a', 'b'), array('b', 'a') + array('a', 'b'))
      assert.equal(array('a', 'b', 'b', 'a'), array('a', 'b') .. array('b', 'a'))
      assert.equal(array('b', 'a', 'a', 'b'), array('b', 'a') .. array('a', 'b'))
      assert.equal(array('a', 'b'), array('a', 'b') - array())
      assert.equal(array('b'), array('a', 'b') - array(1))
      assert.equal(array('b'), array('a', 'b') - 1)
      assert.equal(array(), array('a', 'b') - array(1, 1))
      assert.equal(array(), array('a', 'b') - array(2, 1))
      assert.equal(array(), array('a', 'b') - array(1, 2))
      assert.equal(array(), array('a', 'b') - array(2, 2))
    end)
  end)
  it("regular operations", function()
    assert.equal(array('a', 'b', 'c'), table.map(array('a', 'b', 'c')))
    assert.is_function(t.fn.noop)
    assert.equal('a', array('a')[1])
    assert.is_table(array('a', 'b'))
  end)
  it("of", function()
    local nums = array:of(tonumber)
    assert.is_table(nums)
    assert.equal(nums(1, 7, 88), nums('1', '7', '88'))
  end)
  it("compare", function()
    assert.is_true(array('a', 'b', 'c', 'd') == array('a', 'b', 'c', 'd'))
    assert.is_true(array('a', 'd', 'b', 'c') ~= array('a', 'b', 'c', 'd'))
  end)
  it("map", function()
    local nums = array:of(tonumber)
    assert.equal(nums('2', '14', '176'), nums('1', '7', '88') * function(x) return tonumber(x)*2 end)
    assert.equal(nums(2, 14, 176), nums('2', '14', '176'))
  end)
  it("filter", function()
    local nums = array:of(tonumber)
    assert.equal(nums(88), nums('1', '7', '88') % function(x) return tonumber(x)>50 end)
  end)
  it("__tostring", function()
    local nums = array:of(tonumber)
    assert.equal('1\n7\n88', tostring(nums('1', '7', '88')))
  end)
  it("array.flatten", function()
    assert.same({"y", "x", "z"}, array.flatten({{"y", "x", "z"}}))
    assert.same({"y", "x", "z"}, array:flatten({{"y", "x", "z"}}))
  end)
end)
