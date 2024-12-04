describe("number.positive", function()
  local t, is, positive
  setup(function()
    t = require "t"
    is, positive = t.is, t.number.positive
  end)
  it("meta", function()
    assert.is_true(is.callable(positive))
  end)
  it("positive", function()
    for i=1,512 do
      assert.equal(i, positive(i))
    end
  end)
  it("positive", function()
    assert.is_nil(positive(-math.pi))
    assert.is_nil(positive(0))
    assert.is_nil(positive(-1))
    assert.is_nil(positive(""), '""')
    assert.is_nil(positive(' '))
    assert.is_nil(positive('  '))
    assert.is_nil(positive('	'))
    assert.is_nil(positive('		'))
    assert.is_nil(positive("	\r 	"))
    assert.is_nil(positive("	\n 	"))
    assert.is_nil(positive(false), 'false')
    assert.is_nil(positive(true), 'false')
    assert.is_nil(positive({}), '{}')
    assert.is_nil(positive("false"), '"false"')
    assert.is_nil(positive("0"), '"0"')
    assert.is_nil(positive("FALSE"), '"FALSE"')
  end)
  it("nil", function()
    assert.is_nil(positive(nil), 'nil')
    assert.is_nil(positive(), 'no arg')
  end)
end)