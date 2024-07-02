describe("t.fn.combined", function()
  local t, combined
  setup(function()
    t = require "t"
    combined = t.fn.combined
  end)
  it("t.country + tostring", function()
    local f = combined(t.country, tostring)
    assert.equal('RU', f('russia'))
  end)
  it("nil", function()
    local f = combined(nil, nil)
    assert.equal('russia', f('russia'))
  end)
end)
