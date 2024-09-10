describe("date", function()
  local t, date, timestamp
  setup(function()
    t = require "t"
    date = t.date
    timestamp = t.timestamp
  end)
  it("date", function()
    local ts = "Sat Feb 24 17:11:49 GMT 2024"
    assert.equal(1708783909, timestamp(ts))
    assert.equal(1708783909, tonumber(date(ts)))
  end)
end)
